import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

void registerBackendSessionTests() {
  final httpService = HttpService();

  group('Backend Session Tests -', () {
    testWidgets(
      'Save session for appId com.filledstacks.bookshelf works with correct apiKey',
      (tester) async {
        final session = Session(
          id: '1234',
          createdAtTimestamp: 0,
          events: [
            UIEvent.tap(
              position: EventPosition(x: 0, y: 0),
              id: '',
            ),
            UIEvent.tap(
              position: EventPosition(x: 1, y: 1),
              id: '',
            ),
            UIEvent.tap(position: EventPosition(x: 2, y: 2), id: ''),
          ],
          exception: 'Exception: Error dude',
          priority: SessionPriority.low,
          stackTrace: 'Some stack trace at session.dart 14:23',
          views: ['/', 'book-list-view/', 'book-details-view/'],
          sessionStats: SessionStats.empty(),
        );

        final result = await httpService.saveSession(session: session);
        expect(result, true);
      },
    );

    testWidgets(
        'getSessions for com.filledstacks.bookshelf should return 1 result',
        (widgetTester) async {
      final sessions = await httpService.getSessions();
      expect(sessions.length, 1);
    });

    testWidgets(
        'after deleteSessions for com.filledstacks.bookshelf, should return 1',
        (widgetTester) async {
      final deleteResult = await httpService.deleteSessions();
      expect(deleteResult, true);

      final sessions = await httpService.getSessions();
      expect(sessions.length, 0);
    });
  });
}