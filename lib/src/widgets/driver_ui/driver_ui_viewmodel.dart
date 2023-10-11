import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/notification_extractor.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

const String kLoadingSessionsKey = 'loading-sessions-key';

class DriverUIViewModel extends ReactiveViewModel {
  final VoidCallback onReplayCompleted;

  final _notificationExtractor = locator<NotificationExtractor>();

  DriverUIViewModel({required this.onReplayCompleted}) {
    _driverCommunicationService.setOnReplayCompletedCallback(onReplayCompleted);

    _notificationController.stream
        .where(_notificationExtractor.onlyScrollUpdateNotification)
        .map(_notificationExtractor.notificationToScrollableDescription)
        .listen((notification) => viewEvents =
            _notificationExtractor.scrollEvents(notification, viewEvents));

    _routeTracker.addListener(() {
      rebuildUi();
    });
  }

  final _configurationService = locator<ConfigurationService>();
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();
  final _hiveService = locator<HiveService>();
  final _httpService = locator<HttpService>();
  final _routeTracker = locator<SessionMateRouteTracker>();

  final _notificationController = StreamController<Notification>.broadcast();

  ValueNotifier<List<UIEvent>> eventsNotifier = ValueNotifier([]);

  List<UIEvent> get viewEvents => eventsNotifier.value;

  String get currentView => _routeTracker.currentRoute;

  String get currentNavigationStackId => _sessionService.navigationStackId;

  set viewEvents(List<UIEvent> events) {
    eventsNotifier.value = events;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _driverCommunicationService,
        _sessionService,
      ];

  List<Session> _sessions = [];

  Session? _selectedSession;

  bool get hasSelectedSession => _selectedSession != null;

  List<UIEvent> get sessionInteractions =>
      _sessionService.uiEvents.toSet().toList();

  List<UIEvent> get scrollInteractions => _sessionService.uiEvents
      .toSet()
      .where((e) => e.type == InteractionType.scroll)
      .toList();

  List<Session> get sessions => _sessions;

  bool get showReplayUI =>
      ((_driverCommunicationService.readyToReplay ||
              !_driverCommunicationService.wasReplayExecuted) &&
          !isGuestAppLoading) ||
      kForceDriverUI;

  bool _isGuestAppLoading = false;
  bool get isGuestAppLoading => _isGuestAppLoading;

  bool _showDebugInformation = false;
  bool get showDebugInformation => _showDebugInformation;

  bool _showDriverBar = true;
  bool get showDriverBar => _showDriverBar && sessions.isNotEmpty;

  bool _showSessionList = true;
  bool get showSessionList => _showSessionList;

  bool _showEmptySessionsMessage = false;
  bool get showEmptySessionsMessage => _showEmptySessionsMessage;

  Future<void> loadSessions() async {
    if (kLocalOnlyUsage) {
      _sessions = _hiveService.getSessions().toList();
      notifyListeners();
    } else {
      _sessions = await runBusyFuture<List<Session>>(
        _httpService.getSessions(),
        throwException: true,
      );
    }

    _showEmptySessionsMessage = sessions.isEmpty;
  }

  Future<void> startSession() async {
    if (_selectedSession == null) {
      print('⚠️  Ups! No session selected!');
      return;
    }

    _isGuestAppLoading = true;
    rebuildUi();

    await Future.delayed(
      Duration(milliseconds: _configurationService.minimumStartupTime),
    );

    /// TODO(refactor): change this state when guest app finishes loading, we
    /// need to find a way to get notified of the event.
    _isGuestAppLoading = false;

    _driverCommunicationService.sendInteractions(
      _sessionService.uiEvents,
    );
  }

  void onEventTapped(UIEvent event) {
    print('onEventTapped - $event');

    _showDebugInformation = !_showDebugInformation;
    rebuildUi();
  }

  void toggleDriverBar() {
    _showDriverBar = !_showDriverBar;
    rebuildUi();
  }

  void toggleSessionList() {
    _showSessionList = !_showSessionList;
    rebuildUi();
  }

  void toggleDebugMode() {
    _showDebugInformation = !_showDebugInformation;
    rebuildUi();
  }

  void selectSession(int index) {
    _selectedSession = _sessions[index];

    _sessionService.setActiveSession(_selectedSession!);

    eventsNotifier.value =
        _selectedSession!.events.whereType<UIEvent>().toList();

    print('DriverViewmodel - SessionSelected ${_selectedSession?.id}');

    notifyListeners();
  }

  bool isSessionSelected(int index) => _selectedSession == sessions[index];

  bool onClientNotifiaction(Notification notification) {
    _notificationController.add(notification);

    /// We return false to keep the notification bubbling in the widget tree
    return false;
  }
}
