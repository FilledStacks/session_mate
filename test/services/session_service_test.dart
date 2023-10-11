import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../helpers/test_helpers.dart';

void main() {
  SessionService getService() => SessionService();

  group('SessionServiceTest -', () {
    setUpAll(() => registerServices());

    group('addEvent -', () {
      test('When called with a UIEvent, should have 1 in session and ui events',
          () {
        final service = getService();
        service.addEvent(
          UIEvent.input(position: EventPosition(x: 0, y: 0), id: ''),
        );

        expect(service.sessionEvents.length, 1);
        expect(
          service.uiEvents.length,
          1,
          reason: 'If type UI event it should also be added to UI events list',
        );
      });

      test(
          'When called with a NetworkEvent, should have 1 in session and network events',
          () {
        final service = getService();
        service.addEvent(RequestEvent(
          uid: 'uid',
          url: 'url',
          method: 'method',
          headers: {},
        ));

        expect(service.sessionEvents.length, 1);
        expect(
          service.networkEvents.length,
          1,
          reason:
              'If type NetworkEvent it should also be added to netwwork events list',
        );
      });

      test(
          'When called with tap, followed by input at the same location, should remove the tap event',
          () {
        final service = getService();
        service.addEvent(
            TapEvent(position: EventPosition(x: 10, y: 10, xDeviation: 9)));
        service.addEvent(InputEvent(position: EventPosition(x: 10, y: 10)));

        expect(service.uiEvents.length, 1);
        expect(service.uiEvents.first.type, InteractionType.input);
      });
    });

    group('captureSession -', () {
      test('When called, should return the current session with all events',
          () {
        final service = getService();
        service.addEvent(
          UIEvent.input(position: EventPosition(x: 0, y: 0), id: ''),
        );
        service.addEvent(
          UIEvent.input(position: EventPosition(x: 1, y: 0), id: ''),
        );
        service.addEvent(
          UIEvent.input(position: EventPosition(x: 1, y: 1), id: ''),
        );
        service.addEvent(
          UIEvent.input(position: EventPosition(x: 0, y: 1), id: ''),
        );

        final session = service.captureSession();
        expect(session.events.length, 4);
      });
    });
  });
}
