import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'hive_storage_service.dart';

class SessionService {
  final localStorageService = locator<HiveStorageService>();

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

  // bool _requestHandled = false;

  void addEvent(SessionEvent event) {
    _sessionEvents.add(event);

    if (event is UIEvent) {
      _uiEvents.add(event);
    } else if (event is NetworkEvent) {
      _networkEvents.add(event);
    }
  }

  void addAllEvent(List<SessionEvent> events) {
    _sessionEvents.addAll(events);

    for (var event in events) {
      if (event is UIEvent) {
        _uiEvents.add(event);
      } else if (event is NetworkEvent) {
        _networkEvents.add(event);
      }
    }
  }

  void clear() {
    _networkEvents.clear();
    _sessionEvents.clear();
    _uiEvents.clear();
  }

  Session captureSession() {
    print('captureeeeeee start');
    for (var e in _sessionEvents) {
      print('service :: type:${e.runtimeType}, $e');
    }

    print('events count:${_sessionEvents.length}');

    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      // events: _sessionEvents,
      events: [
        UIEvent(
            position: EventPosition(x: 70, y: 320), type: InteractionType.tap),
        UIEvent(
            position: EventPosition(x: 70, y: 330), type: InteractionType.tap),
        UIEvent(
          position: EventPosition(x: 193.13337053571428, y: 345.89285714285717),
          type: InteractionType.tap,
        ),
        RequestEvent(
          uid: 'qwer-asdf-zxcv',
          url: 'https://rickandmortyapi.com/api',
          method: 'GET',
          headers: {},
        ),
      ],
    );

    clear();

    for (var e in session.events) {
      print('session :: type:${e.runtimeType}, $e');
    }
    print('captureeeeeee finish');

    return session;
  }

  String _hashEvent(NetworkEvent event) {
    return sha256.convert(utf8.encode(jsonEncode(event))).toString();
  }

  void populateSession() {
    final sessions = localStorageService.getSessions();
    if (sessions.isEmpty) return;

    addAllEvent(sessions.last.events);
  }

  void populateCache() {
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

  Future<void> sendEvent(NetworkEvent event) async {
    if (kRecordUserInteractions) {
      addEvent(event);

      // Is temporal, what triggers the save session?
      if (sessionEvents.length >= 8) {
        localStorageService.saveSession(captureSession());
      }
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

  Future<List<int>> getResponseData(List<int> data) async {
    if (kRecordUserInteractions) return data;

    while (_isCurrentEventARequest) {
      await Future.delayed(Duration(microseconds: 100));
    }

    // final response = _cache[_latestRequestEventHash];
    // if (response == null) return [];

    // return (response as ResponseEvent).body ?? [];

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
