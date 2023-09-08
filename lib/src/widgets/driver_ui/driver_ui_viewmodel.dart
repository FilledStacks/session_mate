import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends ReactiveViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();
  final _hiveService = locator<HiveService>();

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
      _driverCommunicationService.readyToReplay || kForceDriverUI;

  bool _showDebugInformation = false;
  bool get showDebugInformation => _showDebugInformation;

  bool _showDriverBar = true;
  bool get showDriverBar => _showDriverBar;

  bool _showSessionList = true;
  bool get showSessionList => _showSessionList;

  void loadSessions() {
    _sessions = _hiveService.getSessions().toList();
    notifyListeners();
  }

  void startSession() {
    print('Starting session...');
    _sessionService.clear();
    _sessionService.setActiveSession(_selectedSession!);

    notifyListeners();

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
    print('DriverViewmodel - SessionSelected ${_selectedSession?.id}');
    notifyListeners();
  }

  bool isSessionSelected(int index) => _selectedSession == sessions[index];
}
