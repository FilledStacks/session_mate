import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/services/configuration_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  ConfigurationService getService() => ConfigurationService();

  group('ConfigurationServiceTest -', () {
    setUpAll(() => registerServices());

    group('getters -', () {
      test('When called, should get the correct values', () {
        final service = getService();

        expect(service.dataMaskingEnabled, true);
        expect(service.keysToExcludeOnDataMasking, []);
        expect(service.minimumStartupTime, 5000);
      });
    });

    group('setValues -', () {
      test('When called without values, should get the default values', () {
        final service = getService();
        service.setValues();

        expect(service.dataMaskingEnabled, true);
        expect(service.keysToExcludeOnDataMasking, []);
        expect(service.minimumStartupTime, 5000);
      });

      test('When called, should set the correct values', () {
        final service = getService();
        service.setValues(
          dataMaskingEnabled: false,
          keysToExcludeOnDataMasking: ['uid'],
          minimumStartupTime: 1000,
        );

        expect(service.dataMaskingEnabled, false);
        expect(service.keysToExcludeOnDataMasking, ['uid']);
        expect(service.minimumStartupTime, 1000);
      });

      test('When called, should set the correct values', () {
        final service = getService();
        service.setValues();

        expect(service.dataMaskingEnabled, true);
        expect(service.keysToExcludeOnDataMasking, []);
        expect(service.minimumStartupTime, 5000);

        service.setValues(minimumStartupTime: 1000);

        expect(service.dataMaskingEnabled, true);
        expect(service.keysToExcludeOnDataMasking, []);
        expect(service.minimumStartupTime, 1000);

        service.setValues(keysToExcludeOnDataMasking: ['token', 'headers']);

        expect(service.dataMaskingEnabled, true);
        expect(service.keysToExcludeOnDataMasking, ['token', 'headers']);
        expect(service.minimumStartupTime, 1000);
      });
    });
  });
}
