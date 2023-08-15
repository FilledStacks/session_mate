import 'package:session_mate_core/session_mate_core.dart';

class SessionService {
  final List<NetworkEvent> _networkInteractions = [];
  List<NetworkEvent> get networkInteractions => _networkInteractions;

  final List<SessionEvent> _sessionInteractions = [];
  List<SessionEvent> get sessionInteractions => _sessionInteractions;

  final List<UIEvent> _userInteractions = [];
  List<UIEvent> get userInteractions => _userInteractions;

  void addEvent(SessionEvent event) {
    _sessionInteractions.add(event);

    if (event is UIEvent) {
      _userInteractions.add(event);
    } else if (event is NetworkEvent) {
      _networkInteractions.add(event);
    }
  }

  void addAllEvent(List<SessionEvent> events) {
    _sessionInteractions.addAll(events);

    for (var event in events) {
      if (event is UIEvent) {
        _userInteractions.add(event);
      } else if (event is NetworkEvent) {
        _networkInteractions.add(event);
      }
    }
  }

  void clear() {
    _networkInteractions.clear();
    _sessionInteractions.clear();
    _userInteractions.clear();
  }
}
