import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

const String kLoadingSessionsKey = 'loading-sessions-key';

class DriverUIViewModel extends ReactiveViewModel {
  final VoidCallback onReplayCompleted;
  DriverUIViewModel({required this.onReplayCompleted}) {
    _driverCommunicationService.setOnReplayCompletedCallback(onReplayCompleted);
  }

  final _configurationService = locator<ConfigurationService>();
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();
  final _hiveService = locator<HiveService>();
  final _httpService = locator<HttpService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _driverCommunicationService,
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
      _sessions = await runBusyFuture(
        _httpService.getSessions(),
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

    final eventsSortedAscending = _sessionService.uiEvents
      ..sort(
        (event1, event2) => event1.order.compareTo(event2.order),
      );

    _driverCommunicationService.sendInteractions(
      eventsSortedAscending,
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

    print('DriverViewmodel - SessionSelected ${_selectedSession?.id}');

    notifyListeners();
  }

  bool isSessionSelected(int index) => _selectedSession == sessions[index];
}
