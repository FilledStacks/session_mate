import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate_core/session_mate_core.dart';

void main() {
  group('CryptoHelperTest -', () {
    group('hashEvent -', () {
      test('When called, should get the correct value', () {
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
          '0d269061640a2b2b4475dc6ab8b8c641efdcc24146af3c850c87b92d0cdc3294',
        );
      });

      test('When called, should get the correct value', () {
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
          '2fe52dda1ce1f9a27455ab7b379af1df7e07155119a2746419c04a93f4556181',
        );
      });
    });
  });
}
