import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

void registerLocalSessionTests() {
  Hive.resetAdapters();
  final hiveService = HiveService();

  group('Local Session Tests -', () {
    testWidgets(
        'When we save a session locally, one session should be returned from the service',
        (tester) async {
      await hiveService.init(forceDestroyDB: true);

      hiveService.saveSession(Session(
        createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
        events: [
          TapEvent(
              position: EventPosition(
                  capturedDeviceHeight: 10,
                  capturedDeviceWidth: 10,
                  x: 10,
                  xDeviation: 10,
                  y: 10,
                  yDeviation: 10),
              externalities: [
                ScrollableDescription(
                  axis: ScrollAxis.horizontal,
                  rect: ScrollableRect(0, 0, 0, 0),
                  scrollOffsetInPixels: 0,
                  maxScrollExtentByPixels: 0,
                )
              ])
        ],
        id: '1234',
        sessionStats: SessionStats(occurrences: 1),
      ));

      final result = hiveService.getSessions().toList();
      expect(
        result.length,
        1,
        reason: 'There should be only the session saved before this',
      );
    });
  });
}
