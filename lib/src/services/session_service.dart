import 'package:session_mate_core/session_mate_core.dart';

class SessionService {
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
    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      events: _sessionEvents,
    );

    clear();

    return session;
  }
}
