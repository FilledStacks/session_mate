import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

import 'session_replay_service.dart';

class SessionService with ListenableServiceMixin {
  final _sessionReplayService = locator<SessionReplayService>();
  final _timeUtils = locator<TimeUtils>();

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
    _sessionEvents.add(event);

    if (event is UIEvent) {
      _uiEvents.add(event);

      if (event.type == InteractionType.onKeyboardEnterEvent) {
        addEvent(RawKeyEvent(type: InteractionType.backPressEvent));
      }
      return;
    }

    _networkEvents.add(event as NetworkEvent);
  }

  void addAllEvents(List<SessionEvent> events) {
    logSweetCoreEvent('SessionService - populate ${events.length} events');
    _sessionEvents.addAll(events);

    for (var event in events) {
      if (event is UIEvent) {
        logUIEvent('Populate event', event: event);
        _uiEvents.add(event);
      } else if (event is NetworkEvent) {
        // we can probably change this to response events
        logResponse(event as ResponseEvent);
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
    logSweetCoreEvent('SessionService - clear all events');
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

    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
      events: [..._sessionEvents],
      views: _views,
      exception: exception.toString(),
      stackTrace: stackTrace.toString(),
      sessionStats: SessionStats.empty(),
    );

    logSession(session);

    return session;
  }

  void clearNavigationStack() {
    _views.clear();
    notifyListeners();
  }

  void checkForEnterPressed(String triggerType) {
    if (_uiEvents.isNotEmpty && _uiEvents.last.type == InteractionType.input) {
      logSweetCoreEvent(
        'We received a $triggerType immediately after input. Add onKeyboardEnterEvent to session.',
      );
      addEvent(RawKeyEvent(
        type: InteractionType.onKeyboardEnterEvent,
        order: _timeUtils.timestamp,
        startedAt: _timeUtils.timestamp,
      ));
    }
  }
}
