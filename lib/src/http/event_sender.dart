import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'request_event.dart';
import 'response_event.dart';

class EventSender {
  static final Map<String, Event> _cache = {};

  // we should probably change this to be available per request
  static bool _requestHandled = false;
  static bool get requestHandled => _requestHandled;

  static String? _requestUidToMockResponse;
  static String? get requestUidToMockResponse => _requestUidToMockResponse;

  static bool _shouldMockResponse = false;
  static bool get shouldMockResponse => _shouldMockResponse;

  static sendEvent(Event event) async {
    final normalizedEvent = _normalizeEvent(event);
    if (normalizedEvent is HttpResponseEvent) {
      _handleResponse(normalizedEvent);
      _requestHandled = false;
      return;
    }

    _handleRequest(normalizedEvent);
    _requestHandled = true;

    print('There are ${_cache.length} items in the CACHE\n');
  }

  static String _hashEvent(Event event) {
    final normalizedEvent = _normalizeEvent(event, uid: true);
    return sha256
        .convert(utf8.encode(jsonEncode(normalizedEvent.arguments)))
        .toString();
  }

  static Event _normalizeEvent(
    Event event, {
    bool uid = false,
  }) {
    if (event is HttpResponseEvent) {
      return HttpResponseEvent(
        uid ? '' : event.arguments['uid'],
        event.arguments['tookMs'],
        event.arguments['code'],
        event.arguments['headers'],
        event.arguments['error'],
        event.hasBody ? event.arguments['body'] : null,
      );
    }

    return HttpRequestEvent(
      uid ? '' : event.arguments['uid'],
      event.arguments['url'],
      event.arguments['method'],
      event.arguments['headers'],
      event.hasBody ? event.arguments['body'] : null,
    );
  }

  static void _saveEvent(String hash, Event event) {
    if (event is! HttpRequestEvent) return;

    _cache.putIfAbsent(hash, () => event);
  }

  static void _handleRequest(Event event) {
    final hash = _hashEvent(event);
    final hasEvent = _cache.containsKey(hash);

    if (hasEvent && event is HttpRequestEvent) {
      _requestUidToMockResponse = event.uid;
      return;
    }

    _saveEvent(hash, event);
  }

  static void _handleResponse(Event event) {
    if (event is! HttpResponseEvent) return;

    if (event.uid == _requestUidToMockResponse) {
      _shouldMockResponse = true;
    } else {
      _shouldMockResponse = false;
    }
  }

  static List<int> mockData() {
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

abstract class Event {
  String get name;
  Map<String, dynamic> get arguments;

  bool get hasBody {
    if (arguments['body'] == null || arguments['body'].isEmpty) {
      return false;
    }

    return true;
  }

  Map<String, dynamic> get jsonBody =>
      jsonDecode(String.fromCharCodes(arguments['body']));
}
