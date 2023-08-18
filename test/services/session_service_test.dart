import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../helpers/test_helpers.dart';

void main() {
  SessionService _getService() => SessionService();

  group('SessionServiceTest -', () {
    setUpAll(() => registerServices());

    group('addEvent -', () {
      test('When called with a UIEvent, should have 1 in session and ui events',
          () {
        final service = _getService();
        service.addEvent(
          UIEvent(
            position: EventPosition(x: 0, y: 0),
            type: InteractionType.input,
          ),
        );

        expect(service.sessionEvents.length, 1);
        expect(
          service.uiEvents.length,
          1,
          reason: 'If type UI event it should also be added to UI events list',
        );
      });
    });
  });
}
