import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'hive_service.dart';

class SessionService {
  final localStorageService = locator<HiveService>();

  final List<NetworkEvent> _networkEvents = [];
  List<NetworkEvent> get networkEvents => _networkEvents;

  final List<SessionEvent> _sessionEvents = [];
  List<SessionEvent> get sessionEvents => _sessionEvents;

  final List<UIEvent> _uiEvents = [];
  List<UIEvent> get uiEvents => _uiEvents;

  final Map<String, NetworkEvent> _cache = {};

  NetworkEvent? _currentEvent;
  String? _latestRequestEventHash;

  bool get _isCurrentEventARequest =>
      _currentEvent != null && _currentEvent is RequestEvent;

  void addEvent(SessionEvent event) {
    _sessionEvents.add(event);

    if (event is UIEvent) {
      _uiEvents.add(event);
      return;
    }

    _networkEvents.add(event as NetworkEvent);
  }

  void addAllEvents(List<SessionEvent> events) {
    print('SessionService - populate all events. ${events.length}');
    _sessionEvents.addAll(events);

    for (var event in events) {
      if (event is UIEvent) {
        _uiEvents.add(event);
      } else if (event is NetworkEvent) {
        _networkEvents.add(event);
      }
    }
  }

  void setActiveSession(Session selectedSession) {
    clear();

    addAllEvents(selectedSession.events);

    populateCache();
  }

  void clear() {
    print('SessionService - clear all events');
    _networkEvents.clear();
    _sessionEvents.clear();
    _uiEvents.clear();
  }

  Session captureSession() {
    print('events count:${_sessionEvents.length}');

    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      events: _sessionEvents,
      // events: [
      //   UIEvent(
      //     position: EventPosition(x: 340, y: 600),
      //     type: InteractionType.tap,
      //   ),
      //   UIEvent(
      //     position: EventPosition(x: 364.93443080357144, y: 672.7232142857143),
      //     type: InteractionType.tap,
      //   ),
      //   RequestEvent(
      //     uid: 'fc9de6e9-d301-4b7d-b688-a187d40317b6',
      //     url:
      //         'https://www.googleapis.com/books/v1/volumes?q=%7Bdevelopment%7D',
      //     method: 'GET',
      //     headers: {
      //       "user-agent": "Dart/3.0 (dart:io)",
      //       "accept-encoding": "gzip",
      //       "content-length": "0",
      //       "host": "www.googleapis.com",
      //     },
      //   ),
      //   ResponseEvent(
      //     uid: 'fc9de6e9-d301-4b7d-b688-a187d40317b6',
      //     timeMs: 1125,
      //     code: 200,
      //     headers: {
      //       "alt-svc": 'h3=":443"; ma=2592000,h3-29=":443"; ma=2592000',
      //       "cache-control": "private",
      //       "transfer-encoding": "chunked",
      //       "date": "Thu, 17 Aug 2023 17:22:51 GMT",
      //       "vary": "Origin",
      //       "content-encoding": "gzip",
      //       "x-frame-options": "SAMEORIGIN",
      //       "content-type": "application/json; charset=UTF-8",
      //       "x-xss-protection": "0",
      //       "x-content-type-options": "nosniff",
      //       "server": "ESF",
      //     },
      //     body: Uint8List.fromList(jsonEncode({"kind": "books#volumes", "totalItems": 666, "items": []}).codeUnits),
      //   ),
      //   UIEvent(
      //     position: EventPosition(x: 340, y: 610),
      //     type: InteractionType.tap,
      //   ),
      //   UIEvent(
      //     position: EventPosition(x: 370, y: 620),
      //     type: InteractionType.tap,
      //   ),
      // ],
    );

    clear();

    return session;
  }

  // TODO(Refactor): This needs to move out of the session service
  String _hashEvent(NetworkEvent event) {
    return sha256.convert(utf8.encode(jsonEncode(event))).toString();
  }

  // TODO(Refactor): This needs to move out of the session service
  void populateCache() {
    print('SessionService - Populate network cache');
    NetworkEvent? hashable;
    for (var e in _networkEvents) {
      if (e is RequestEvent) {
        hashable = e.copyWith(
          uid: '',
          body: e.hasBody ? e.body : null,
        );
        continue;
      }
      // else {
      //   hashable = (e as ResponseEvent).copyWith(
      //     uid: '',
      //     timeMs: 0,
      //     headers: {},
      //     body: e.hasBody ? e.body : null,
      //   );
      // }

      if (hashable == null) return;

      _cache.putIfAbsent(_hashEvent(hashable), () => e);
    }
  }

  // bool hasEventOnCache(String key) => _cache.containsKey(key);

  // TODO(Refactor): This needs to move out of the session service
  Future<void> sendEvent(NetworkEvent event) async {
    if (kRecordUserInteractions) {
      addEvent(event);
      return;
    }

    _currentEvent = event;
    if (event is RequestEvent) {
      _latestRequestEventHash = _hashEvent(event.copyWith(
        uid: '',
        body: event.hasBody ? event.body : null,
      ));
    }
  }

  // TODO(Refactor): This needs to move out of the session service
  Future<List<int>> getResponseData(List<int> data) async {
    if (kRecordUserInteractions) return data;

    while (_isCurrentEventARequest) {
      await Future.delayed(Duration(microseconds: 100));
    }

    final response = _cache[_latestRequestEventHash];
    if (response == null) return data;

    return (response as ResponseEvent).body ?? data;

    final mockData = {"kind": "books#volumes", "totalItems": 666, "items": []};

    return jsonEncode(mockData).codeUnits;
  }
}
