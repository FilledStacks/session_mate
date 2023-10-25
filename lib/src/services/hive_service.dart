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
      ..registerAdapter(SessionImplAdapter()) // 0
      ..registerAdapter(InteractionTypeAdapter()) // 1
      ..registerAdapter(EventPositionImplAdapter()) // 2
      ..registerAdapter(RequestEventImplAdapter()) // 3
      ..registerAdapter(ResponseEventImplAdapter()) // 4
      ..registerAdapter(SessionPriorityAdapter()) // 5
      ..registerAdapter(TapEventImplAdapter()) // 6
      ..registerAdapter(InputEventImplAdapter()) // 7
      ..registerAdapter(ScrollEventImplAdapter()) // 8
      ..registerAdapter(RawKeyEventImplAdapter()) // 9
      ..registerAdapter(SessionStatsImplAdapter()) // 10
      ..registerAdapter(ScrollableDescriptionImplAdapter()) // 11
      ..registerAdapter(ScrollableRectImplAdapter()) // 12
      ..registerAdapter(ScrollMetricsImplAdapter()) // 13
      ..registerAdapter(ScrollAxisAdapter()) // 14
      ..registerAdapter(ScrollDirectionAdapter()); // 15

    sessionsBox = await Hive.openBox<Session>('sessions');
  }

  void saveSession(Session session) {
    sessionsBox.put(session.id, session);
  }

  Iterable<Session> getSessions() {
    return sessionsBox.values.cast<Session>();
  }
}
