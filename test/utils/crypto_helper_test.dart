import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate_core/session_mate_core.dart';

void main() {
  group('CryptoHelperTest -', () {
    group('hashEvent -', () {
      test('When called rickandmortyapi, should get the correct value', () {
        final event = RequestEvent(
          uid: '123456',
          url: 'rickandmortyapi.com',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'rickandmortyapi.com',
          },
        );

        expect(
          hashEvent(event),
          'f551e877d8f514da2ddf747a52dd14ee93a23b3a472f2e75562e81917081ec70',
        );
      });

      test('When called with local host, should get the correct value', () {
        final event = RequestEvent(
          uid: '123456',
          url: 'localhost',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'localhots',
          },
        );

        expect(
          hashEvent(event),
          'e3eaa3f4be8dad57cba66d67494b882af4f4365acb665f54aa991d87ed53b028',
        );
      });
    });
  });
}
