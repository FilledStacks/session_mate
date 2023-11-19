import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:session_mate_core/session_mate_core.dart';

class HiveService {
  late final Box<Session> sessionsBox;

  Future<void> init({bool forceDestroyDB = false}) async {
    if (!kIsWeb) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    if (forceDestroyDB) {
      await Hive.deleteBoxFromDisk('sessions');
    }

    Hive
      ..registerAdapter(SessionAdapter()) // 0
      ..registerAdapter(InteractionTypeAdapter()) // 1
      ..registerAdapter(EventPositionAdapter()) // 2
      ..registerAdapter(RequestEventAdapter()) // 3
      ..registerAdapter(ResponseEventAdapter()) // 4
      ..registerAdapter(SessionPriorityAdapter()) // 5
      ..registerAdapter(TapEventAdapter()) // 6
      ..registerAdapter(InputEventAdapter()) // 7
      ..registerAdapter(ScrollEventAdapter()) // 8
      ..registerAdapter(RawKeyEventAdapter()) // 9
      ..registerAdapter(SessionStatsAdapter()) // 10
      ..registerAdapter(ScrollableDescriptionAdapter()) // 11
      ..registerAdapter(ScrollableRectAdapter()) // 12
      ..registerAdapter(ScrollMetricsAdapter()) // 13
      ..registerAdapter(ScrollAxisAdapter()) // 14
      ..registerAdapter(ScrollDirectionAdapter()) // 16
      ..registerAdapter(DragEventAdapter()); // 17

    sessionsBox = await Hive.openBox<Session>('sessions');
  }

  Future<void> saveSession(Session session) async {
    await sessionsBox.put(session.id, session);
  }

  Iterable<Session> getSessions() {
    return sessionsBox.values.cast<Session>();
  }
}
