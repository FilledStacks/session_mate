import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:session_mate_core/session_mate_core.dart';

class HiveService {
  late final Box<Session> sessionsBox;

  Future<void> init({bool forceDestroyDB = false}) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);

    Hive.registerAdapter(InteractionTypeAdapter());
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(RequestEventAdapter());
    Hive.registerAdapter(ResponseEventAdapter());
    Hive.registerAdapter(UIEventAdapter());
    Hive.registerAdapter(EventPositionAdapter());

    if (forceDestroyDB) {
      await Hive.deleteBoxFromDisk('sessions');
    }

    sessionsBox = await Hive.openBox<Session>('sessions');

    // temporary code to delete a session on start
    // await sessionsBox.delete('1692293778281');
  }

  void saveSession(Session session) {
    sessionsBox.put(session.id, session);
  }

  Iterable<Session> getSessions() {
    return sessionsBox.values.cast<Session>();
  }
}
