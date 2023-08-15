import 'package:hive/hive.dart';
import 'package:session_mate_core/session_mate_core.dart';

class HiveStorageService {
  late final Box<Session> sessionsBox;

  Future<void> initial() async {
    Hive.init('/');
    sessionsBox = await Hive.openBox('sessions');
  }

  void saveSession(Session session) {
    sessionsBox.put(session.id, session);
  }

  Iterable<Session> getSessions() {
    return sessionsBox.values.cast<Session>();
  }
}
