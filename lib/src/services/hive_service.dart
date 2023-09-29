import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate_core/session_mate_core.dart';

class HiveService {
  final log = getLogger('HiveService');
  late final Box<Session> sessionsBox;

  Future<void> init({bool forceDestroyDB = false}) async {
    if (!kIsWeb) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    Hive
      ..registerAdapter(InteractionTypeAdapter())
      ..registerAdapter(SessionPriorityAdapter())
      ..registerAdapter(SessionAdapter())
      ..registerAdapter(RequestEventAdapter())
      ..registerAdapter(ResponseEventAdapter())
      ..registerAdapter(TapEventAdapter())
      ..registerAdapter(InputEventAdapter())
      ..registerAdapter(ScrollEventAdapter())
      ..registerAdapter(RawKeyEventAdapter())
      ..registerAdapter(EventPositionAdapter());

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
