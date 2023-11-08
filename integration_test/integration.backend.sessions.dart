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
          id: '2ad3538cd5fcbc8f2b04981541358c663844e92ab12dfd01d9a37a4255649948',
          createdAtTimestamp: 1699395020314,
          events: [
            UIEvent.tap(
              id: '3G3XVnFsFe5zcm6yWzkk',
              position: EventPosition(
                x: 235,
                y: 228,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              navigationStackId: '/startup-view-/books-list-view',
              view: '/books-list-view',
              order: 1699395008626,
              startedAt: 1699395008626,
            ),
            UIEvent.scroll(
              id: 'FjvSAhtUTttWn6TBs1zL',
              duration: 681,
              position: EventPosition(
                x: 212,
                y: 580,
              ),
              scrollDelta: EventPosition(
                x: 0,
                y: -156,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              navigationStackId:
                  '/startup-view-/books-list-view-/book-details-view,',
              view: '/books-details-view',
              order: 1699395011976,
              startedAt: 1699395011976,
            ),
            UIEvent.dragEvent(
              id: 'yxvgNQgL0JQE9tbepL9a',
              duration: 554,
              position: EventPosition(
                x: 56,
                y: 498,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              scrollEnd: EventPosition(
                x: 463,
                y: 496,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              navigationStackId: '',
              view: '/books-details-view',
              order: 1699395013372,
              startedAt: 1699395013372,
            ),
            UIEvent.tap(
              id: 'tLVPl3Rb6BAUS7jTnBtR',
              position: EventPosition(
                x: 287,
                y: 653,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              navigationStackId:
                  '/startup-view-/books-list-view-/book-details-view',
              view: '/books-details-view',
              order: 1699395014766,
              startedAt: 1699395014766,
            ),
            UIEvent.input(
              id: 'Rj11HGs1o3RgDRGjlL0a',
              position: EventPosition(
                x: 240,
                y: 664,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              inputData: 'xxxxxx',
              navigationStackId:
                  '/startup-view-/books-list-view-/book-details-view',
              view: '/books-details-view',
              order: 1699395020236,
              startedAt: 1699395020236,
            ),
            UIEvent.tap(
              id: '190qwJK2HWXxtivx0fFN',
              position: EventPosition(
                x: 260,
                y: 810,
                capturedDeviceHeight: 854,
                capturedDeviceWidth: 480,
              ),
              navigationStackId:
                  '/startup-view-/books-list-view-/book-details-view',
              view: '/books-details-view',
              order: 1699395020244,
              startedAt: 1699395020244,
            ),
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
        'after deleteSessions for com.filledstacks.bookshelf, should return 0',
        (widgetTester) async {
      final deleteResult = await httpService.deleteSessions();
      expect(deleteResult, true);

      final sessions = await httpService.getSessions();
      expect(sessions.length, 0);
    });
  });
}
