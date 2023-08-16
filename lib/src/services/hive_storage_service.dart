import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:session_mate_core/session_mate_core.dart';

class HiveStorageService {
  late final Box<Session> sessionsBox;

  Future<void> init({bool forceDestroyDB = false}) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);

    if (forceDestroyDB) {
      await Hive.deleteBoxFromDisk('sessions');
    }

    sessionsBox = await Hive.openBox<Session>('sessions');
  }

  void saveSession(Session session) {
    sessionsBox.put(session.id, session);
  }

  Iterable<Session> getSessions() {
    return sessionsBox.values.cast<Session>();
  }
}
