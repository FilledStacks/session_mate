import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionService {
  final _sessionReplayService = locator<SessionReplayService>();

  final List<NetworkEvent> _networkEvents = [];
  List<NetworkEvent> get networkEvents => _networkEvents;

  final List<SessionEvent> _sessionEvents = [];
  List<SessionEvent> get sessionEvents => _sessionEvents;

  final List<UIEvent> _uiEvents = [];
  List<UIEvent> get uiEvents => _uiEvents;

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

    _sessionReplayService.populateCache(networkEvents);
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
}
