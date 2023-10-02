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
          'fe7e10a46a6fbeabc5d56fe004bab91de4d97bbd547927184b8018aefaef6a19',
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
          '63e9c7f773d0db80a0a9a5fd73804317bccd70e2dd939b85a5428baf911267aa',
        );
      });
    });
  });
}
