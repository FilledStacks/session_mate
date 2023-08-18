import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends BaseViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();
  final _hiveService = locator<HiveService>();

  List<Session> _sessions = [];

  Session? _selectedSession;

  bool get hasSelectedSession => _selectedSession != null;

  List<UIEvent> get sessionInteractions =>
      _sessionService.uiEvents.toSet().toList();

  List<Session> get sessions => _sessions;

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

  void selectSession(int index) {
    _selectedSession = _sessions[index];
    print('DriverViewmodel - SessionSelected ${_selectedSession?.id}');
    notifyListeners();
  }

  bool isSessionSelected(int index) => _selectedSession == sessions[index];
}
