import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

class EventSender {
  static final logger = getLogger('EventSender');
  static final _sessionService = locator<SessionService>();

  static final Map<String, NetworkEvent> _cache = {};

  // we should probably change this to be available per request
  static bool _requestHandled = false;
  static bool get requestHandled => _requestHandled;

  static String? _requestUidToMockResponse;
  static bool _shouldMockResponse = false;

  static sendEvent(NetworkEvent event) async {
    _sessionService.addEvent(event);
    if (event is ResponseEvent) {
      _handleResponse(event.copyWith(
        body: event.body != null && event.body!.isNotEmpty ? event.body : null,
      ));
      _requestHandled = false;
    } else if (event is RequestEvent) {
      _handleRequest(event.copyWith(
        body: event.body != null && event.body!.isNotEmpty ? event.body : null,
      ));
      _requestHandled = true;
    }

    logger.d('There are ${_cache.length} items in the CACHE\n');
    logger.d(
      'There are ${_sessionService.networkInteractions.length} network interactions in the SessionService\n',
    );
    logger.d(
      'There are ${_sessionService.userInteractions.length} user interactions in the SessionService\n',
    );
    logger.d(
      'There are ${_sessionService.sessionInteractions.length} session interactions in the SessionService\n',
    );
    logger.wtf('Cache: $_cache');
  }

  static String _hashEvent(NetworkEvent event) {
    if (event is RequestEvent) {
      return sha256
          .convert(utf8.encode(jsonEncode(event.copyWith(uid: ''))))
          .toString();
    } else if (event is ResponseEvent) {
      return sha256
          .convert(utf8.encode(jsonEncode(event.copyWith(uid: ''))))
          .toString();
    }

    throw Exception('An error occur, the event should be a NetworkEvent.');
  }

  static void _saveEvent(String hash, NetworkEvent event) {
    if (event is! RequestEvent) return;

    _cache.putIfAbsent(hash, () => event);
  }

  static void _handleRequest(RequestEvent event) {
    final hash = _hashEvent(event);
    final hasEvent = _cache.containsKey(hash);

    if (hasEvent) {
      _requestUidToMockResponse = event.uid;
      return;
    }

    _saveEvent(hash, event);
  }

  static void _handleResponse(ResponseEvent event) {
    if (event.uid == _requestUidToMockResponse) {
      _shouldMockResponse = true;
    } else {
      _shouldMockResponse = false;
    }
  }

  static Future<List<int>> getResponseData(List<int> data) async {
    if (!_shouldMockResponse) return data;

    await Future.delayed(Duration(seconds: 1));

    final mockData = {
      "info": {"count": 2, "pages": 1, "next": null, "prev": null},
      "results": [
        {"id": 001, "name": "Dane"},
        {"id": 002, "name": "Fernando"}
      ]
    };

    return jsonEncode(mockData).codeUnits;
  }
}
