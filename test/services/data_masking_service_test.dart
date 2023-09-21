import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/services/data_masking_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  DataMaskingService getService() => DataMaskingService();

  group('DataMaskingServiceTest -', () {
    setUpAll(() => registerServices());

    group('stringSubstitution -', () {
      test('When called with FilledStacks, should return xxxxxxxxxxxx', () {
        final input = 'FilledStacks';
        final service = getService();
        final masked = service.stringSubstitution(input);

        expect(masked, 'xxxxxxxxxxxx');
        expect(masked.length, input.length);
      });

      test('When called with Dane Mackier, should return xxxx xxxxxxx', () {
        final input = 'Dane Mackier';
        final service = getService();
        final masked = service.stringSubstitution(input);

        expect(masked, 'xxxx xxxxxxx');
        expect(masked.length, input.length);
      });
    });

    group('numSubstitution -', () {
      test('When called with 123456, should return 999999', () {
        final input = 123456;
        final service = getService();
        final masked = service.numSubstitution(input);

        expect(masked, 999999);
        expect(masked.toString().length, input.toString().length);
      });

      test('When called with 99.25, should return 99.99', () {
        final input = 99.25;
        final service = getService();
        final masked = service.numSubstitution(input);

        expect(masked, 99.99);
        expect(masked.toString().length, input.toString().length);
      });

      test('When called with 100.00, should return 999.99', () {
        final input = 100.00;
        final service = getService();
        final masked = service.numSubstitution(input);

        expect(
          masked,
          999.99,
          skip:
              "We can't get the number of digits after decimal point, that's why we cannot output 999.99. For this to be accurately, we need to get the output precision on the guest app as an argument.",
        );
        expect(
          masked.toString().length,
          input.toString().length,
          skip:
              "We can't get the number of digits after decimal point, that's why we cannot output 999.99. For this to be accurately, we need to get the output precision on the guest app as an argument.",
        );
      });
    });

    group('handle -', () {
      test('When called with a String, should return the String masked', () {
        final service = getService();
        final masked = service.handle('John Wick');

        expect(masked, 'xxxx xxxx');
      });

      test('When called with an int, should return the int masked', () {
        final service = getService();
        final masked = service.handle(1234);

        expect(masked, 9999);
      });

      test('When called with a double, should return the double masked', () {
        final service = getService();
        final masked = service.handle(10.5);

        expect(masked, 99.9);
      });

      test('When called with a List, should return the List masked', () {
        final service = getService();
        final masked = service.handle(['Dane Mackier', 'Fernando Ferrara']);

        expect(masked, ['xxxx xxxxxxx', 'xxxxxxxx xxxxxxx']);
      });

      test('When called with a Map, should return the Map masked', () {
        final service = getService();
        final masked = service.handle({'agency': 'Filledstacks'});

        expect(masked, {'agency': 'xxxxxxxxxxxx'});
      });

      test(
          'When called with data containing excluded keys, should return the data masked correctly',
          () {
        getAndRegisterConfigurationService(
          excludeKeysOnDataMasking: ['id', 'token', 'code'],
        );
        final service = getService();
        final masked = service.handle({
          'code': 200,
          'data': {
            'id': '123-456-789',
            'name': 'Dane Mackier',
            'token': 'qweasdzxc123456789poilkjmnb'
          }
        });

        expect(masked, {
          'code': 200,
          'data': {
            'id': '123-456-789',
            'name': 'xxxx xxxxxxx',
            'token': 'qweasdzxc123456789poilkjmnb'
          }
        });
      });

      test(
          'When called with a complex object, should return the complex object masked',
          () {
        final service = getService();
        final masked = service.handle([
          {
            'country': 'Argentina',
            'capital': 'Buenos Aires',
            'population': 47327407,
            'official_languages': ['Spanish'],
            'co_official_languages': ['Guarani', 'Quechua', 'Qom', 'Welsh'],
          },
          {
            'country': 'South Africa',
            'capital': 'Cape Town',
            'population': 58048332,
            'official_languages': [
              'Afrikaans',
              'English',
              'Ndebele',
              'Sepedi',
              'Sesotho',
              'Setswana',
              'South African Sign Language',
              'Swazi',
              'Tshivenda',
              'Xhosa',
              'Xitsonga',
              'Zulu'
            ],
            'co_official_languages': [],
          },
        ]);

        expect(masked, [
          {
            'country': 'xxxxxxxxx',
            'capital': 'xxxxxx xxxxx',
            'population': 99999999,
            'official_languages': ['xxxxxxx'],
            'co_official_languages': ['xxxxxxx', 'xxxxxxx', 'xxx', 'xxxxx'],
          },
          {
            'country': 'xxxxx xxxxxx',
            'capital': 'xxxx xxxx',
            'population': 99999999,
            'official_languages': [
              'xxxxxxxxx',
              'xxxxxxx',
              'xxxxxxx',
              'xxxxxx',
              'xxxxxxx',
              'xxxxxxxx',
              'xxxxx xxxxxxx xxxx xxxxxxxx',
              'xxxxx',
              'xxxxxxxxx',
              'xxxxx',
              'xxxxxxxx',
              'xxxx'
            ],
            'co_official_languages': [],
          },
        ]);
      });
    });
  });
}
