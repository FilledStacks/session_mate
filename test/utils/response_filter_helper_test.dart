import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate_core/session_mate_core.dart';

void main() {
  group('ResponseFilterHelperTest -', () {
    final response = ResponseEvent(
      uid: '123456',
      timeMs: 600,
      code: 200,
      headers: {},
    );

    group('hasImageContentType -', () {
      test('When called, should get the correct value', () {
        expect(hasImageContentType(response), isFalse);
      });

      test('When called, should get the correct value', () {
        final event = response.copyWith(headers: {
          'cache-control': 'xxxxxxx',
          'transfer-encoding': 'xxxxxxx',
        });

        expect(hasImageContentType(event), isFalse);
      });

      test('When called, should get the correct value', () {
        final event = response.copyWith(headers: {
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
        });

        expect(hasImageContentType(event), isTrue);
      });

      test('When called, should get the correct value', () {
        final event = response.copyWith(headers: {
          'cache-control': 'private',
          'content-length': '8316',
          'content-type': 'image/webp',
          'server': 'Ocean Content Server',
          'expires': 'Tue, 26 Sep 2023 14:48:48 GMT',
        });

        expect(hasImageContentType(event), isTrue);
      });

      test('When called, should get the correct value', () {
        final event = response.copyWith(headers: {
          'cache-control': 'private',
          'content-length': '8316',
          'content-type': 'image/png',
          'server': 'Ocean Content Server',
          'expires': 'Tue, 26 Sep 2023 14:48:48 GMT',
        });

        expect(hasImageContentType(event), isTrue);
      });
    });

    group('hasMediaContentType -', () {
      test('When called with audio/mpeg, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'audio/mpeg',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with audio/vnd.rn-realaudio, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'audio/vnd.rn-realaudio',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with audio/x-wav, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'audio/x-wav',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with audio/x-ms-wma, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'audio/x-ms-wma',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/gif, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/gif',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/tiff, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/tiff',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/vnd.djvu, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/vnd.djvu',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/jpeg, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/jpeg',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/svg+xml, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/svg+xml',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/png, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/png',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/x-icon, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/x-icon',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with image/vnd.microsoft.icon, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'image/vnd.microsoft.icon',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/mpeg, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/mpeg',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/x-ms-wmv, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/x-ms-wmv',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/x-msvideo, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/x-msvideo',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/webm, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/webm',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/mp4, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/mp4',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/x-flv, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/x-flv',
        });

        expect(hasMediaContentType(event), isTrue);
      });

      test('When called with video/quicktime, should return true', () {
        final event = response.copyWith(headers: {
          'content-type': 'video/quicktime',
        });

        expect(hasMediaContentType(event), isTrue);
      });
    });

    group('stringToContentType -', () {
      test('When called, should get the correct value', () {
        final input = 'image/jpeg';
        final output = ContentType('image', 'jpeg');
        expect(stringToContentType(input).toString(), output.toString());
      });

      test('When called, should get the correct value', () {
        final input = 'application/json; charset=UTF-8';
        final output = ContentType(
          'application',
          'json',
          charset: 'UTF-8',
          parameters: {'charset': 'UTF-8'},
        );
        expect(stringToContentType(input).toString(), output.toString());
      });

      test('When called, should get the correct value', () {
        final input =
            'application/soap+xml; charset=utf-8; action=urn:CreateCredential';
        final output = ContentType(
          'application',
          'soap+xml',
          charset: 'utf-8',
          parameters: {'charset': 'utf-8', 'action': 'urn:CreateCredential'},
        );
        expect(stringToContentType(input).toString(), output.toString());
      });
    });
  });
}
