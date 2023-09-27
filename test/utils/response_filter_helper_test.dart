import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate_core/session_mate_core.dart';

void main() {
  group('ResponseFilterHelperTest -', () {
    group('hasImageContentType -', () {
      test('When called, should get the correct value', () {
        final event = ResponseEvent(
          uid: '123456',
          timeMs: 600,
          code: 200,
          headers: {},
        );

        expect(hasImageContentType(event), false);
      });

      test('When called, should get the correct value', () {
        final event = ResponseEvent(
          uid: '123456',
          timeMs: 600,
          code: 200,
          headers: {'cache-control': 'xxxxxxx', 'transfer-encoding': 'xxxxxxx'},
        );

        expect(hasImageContentType(event), false);
      });

      test('When called, should get the correct value', () {
        final event = ResponseEvent(
          uid: '123456',
          timeMs: 600,
          code: 200,
          headers: {
            'cache-control': 'private',
            'max-age': '86400',
            'accept-ranges': 'bytes',
            'date': 'Tue, 26 Sep 2023 14:48:48 GMT',
            'content-length': '8316',
            'x-frame-options': 'SAMEORIGIN',
            'content-type': 'image/jpeg',
            'x-xss-protection': '0',
            'x-content-type-options': 'nosniff',
            'server': 'Ocean Content Server',
            'expires': 'Tue, 26 Sep 2023 14:48:48 GMT',
          },
        );

        expect(hasImageContentType(event), true);
      });

      test('When called, should get the correct value', () {
        final event = ResponseEvent(
          uid: '123456',
          timeMs: 600,
          code: 200,
          headers: {
            'cache-control': 'private',
            'content-length': '8316',
            'content-type': 'image/webp',
            'server': 'Ocean Content Server',
            'expires': 'Tue, 26 Sep 2023 14:48:48 GMT',
          },
        );

        expect(hasImageContentType(event), true);
      });

      test('When called, should get the correct value', () {
        final event = ResponseEvent(
          uid: '123456',
          timeMs: 600,
          code: 200,
          headers: {
            'cache-control': 'private',
            'content-length': '8316',
            'content-type': 'image/png',
            'server': 'Ocean Content Server',
            'expires': 'Tue, 26 Sep 2023 14:48:48 GMT',
          },
        );

        expect(hasImageContentType(event), true);
      });
    });
  });
}
