import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

import 'session_replay_service.dart';

class SessionService with ListenableServiceMixin {
  final _sessionReplayService = locator<SessionReplayService>();

  final List<NetworkEvent> _networkEvents = [];
  List<NetworkEvent> get networkEvents => _networkEvents;

  final List<SessionEvent> _sessionEvents = [];
  List<SessionEvent> get sessionEvents => _sessionEvents;

  final List<UIEvent> _uiEvents = [];
  List<UIEvent> get uiEvents => _uiEvents;

  final List<String> _views = [];
  List<String> get views => _views;

  String get navigationStackId => _views.join('-');

  void addEvent(SessionEvent event) {
    final removeLastEventBeforeAdding = _checkIfLastEventShouldBeRemoved(event);

    if (removeLastEventBeforeAdding) {
      _sessionEvents.removeLast();
    }

    _sessionEvents.add(event);

    if (event is UIEvent) {
      if (removeLastEventBeforeAdding) {
        _uiEvents.removeLast();
      }

      _uiEvents.add(event);
      return;
    }

    _networkEvents.add(event as NetworkEvent);
  }

  void addAllEvents(List<SessionEvent> events) {
    print('SessionService - populate ${events.length} events');
    _sessionEvents.addAll(events);

    for (var event in events) {
      if (event is UIEvent) {
        _uiEvents.add(event);
      } else if (event is NetworkEvent) {
        _networkEvents.add(event);
      }
    }
  }

  void addView(String view) {
    _views.add(view);
  }

  void setActiveSession(Session selectedSession) {
    clear();

    addAllEvents(selectedSession.events);

    _sessionReplayService.populateCache(networkEvents);

    notifyListeners();
  }

  void clear() {
    print('SessionService - clear all events');
    _networkEvents.clear();
    _sessionEvents.clear();
    _uiEvents.clear();
  }

  Session captureSession({
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (_sessionEvents.isEmpty) {
      throw Exception('No session events available, nothing to save.');
    }

    print('events count:${_sessionEvents.length}');

    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
      events: [..._sessionEvents],
      views: _views,
      exception: exception.toString(),
      stackTrace: stackTrace.toString(),
      sessionStats: SessionStats.empty(),
    );

    return session;
  }

  bool _checkIfLastEventShouldBeRemoved(SessionEvent event) {
    if (event is InputEvent && _sessionEvents.isNotEmpty) {
      final lastAddedSessionEvent = _sessionEvents.last;

      if (lastAddedSessionEvent is TapEvent) {
        final positionHasExactMatch =
            lastAddedSessionEvent.position.x == event.position.x &&
                lastAddedSessionEvent.position.x == event.position.x;

        return positionHasExactMatch;
      }
    }

    return false;
  }

  void clearNavigationStack() {
    _views.clear();
    notifyListeners();
  }
}
