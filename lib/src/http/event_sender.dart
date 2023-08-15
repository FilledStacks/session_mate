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
      _handleResponse(event.copyWith(body: event.hasBody ? event.body : null));
      _requestHandled = false;
      _outputSessionSummary();
    } else if (event is RequestEvent) {
      _handleRequest(event.copyWith(body: event.hasBody ? event.body : null));
      _requestHandled = true;
    }
  }

  static String _hashEvent(NetworkEvent event) {
    return sha256.convert(utf8.encode(jsonEncode(event))).toString();
  }

  static void _saveEvent(String hash, NetworkEvent event) {
    _cache.putIfAbsent(hash, () => event);
  }

  static void _handleRequest(RequestEvent event) {
    final hash = _hashEvent(event.copyWith(uid: ''));
    final isEventCached = _cache.containsKey(hash);

    if (isEventCached) {
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

    final hash = _hashEvent(event.copyWith(uid: '', timeMs: 0, headers: {}));
    final isEventCached = _cache.containsKey(hash);

    if (isEventCached) return;

    _saveEvent(hash, event);
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

  static void _outputSessionSummary() {
    logger.w(
      '\nSessionEvents: ${_sessionService.sessionEvents.length} (${_sessionService.networkEvents.length} NE + ${_sessionService.uiEvents.length} UI), Events in Cache: ${_cache.length}',
    );

    for (var event in _sessionService.sessionEvents) {
      logger.i(event);
    }
  }
}
