import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate_core/session_mate_core.dart';

void main() {
  group('CryptoHelperTest -', () {
    group('hashEvent -', () {
      test(
          'When called with GET method, real request and mock request should have the same hash',
          () {
        final realRequest = RequestEvent(
          uid: '123456',
          url:
              'https://www.googleapis.com/books/v1/volumes?q=subject%3Acomputers',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'googleapis.com',
          },
          view: '/book-details-view',
          order: 1697131738086,
        );

        final mockedRequest = realRequest.copyWith(
          url:
              'https://www.googleapis.com/books/v1/volumes?q=xxxxxxxxxxxxxxxxxxx',
        );

        expect(hashEvent(realRequest), hashEvent(mockedRequest));
      });

      test(
          'When called with GET method, real request and mock request should have the same hash',
          () {
        final realRequest = RequestEvent(
          uid: '123456',
          url:
              'https://filledstacks.api?email=dane@filledstacks.com&password=1234',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'filledstacks.api',
          },
          view: '/book-details-view',
          order: 1697131738086,
        );

        final mockedRequest = realRequest.copyWith(
          url:
              'https://filledstacks.api?email=xxxx@xxxxxxxxxxxx.xxx&password=9999',
        );

        expect(hashEvent(realRequest), hashEvent(mockedRequest));
      });

      test(
          'When called with POST method, real request and mock request should have the same hash',
          () {
        final realRequest = RequestEvent(
          uid: '123456',
          url: 'https://filledstacks.api',
          method: 'POST',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'filledstacks.api',
          },
          body: convertStringToUint8List(jsonEncode({
            'email': 'dane@filledstacks.com',
            'password': '1234',
          })),
          view: '/book-details-view',
          order: 1697131738086,
        );

        final mockedRequest = realRequest.copyWith(
          body: convertStringToUint8List(jsonEncode({
            'email': 'xxxx@xxxxxxxxxxxx.xxx',
            'password': '9999',
          })),
        );

        expect(hashEvent(realRequest), hashEvent(mockedRequest));
      });
    });

    group('prepareBody -', () {
      test('When called, should get the correct data', () {
        final input = {
          'username': 'filledstacks',
          'password': 'session-mate',
          'expiresInMins': 60,
        };

        final streamInput = convertStringToUint8List(jsonEncode(input));
        final streamOutput = prepareBody(streamInput);

        final output = {
          'username': 12,
          'password': 12,
          'expiresInMins': 2,
        };

        expect(output, jsonDecode(convertUint8ListToString(streamOutput!)));
      });

      test('When called, should get the correct data', () {
        final input = {
          'username': 'xxxxxxxxxxxx',
          'password': 'xxxxxxx-xxxx',
          'expiresInMins': 99,
        };

        final streamInput = convertStringToUint8List(jsonEncode(input));
        final streamOutput = prepareBody(streamInput);

        final output = {
          'username': 12,
          'password': 12,
          'expiresInMins': 2,
        };

        expect(output, jsonDecode(convertUint8ListToString(streamOutput!)));
      });

      test('When called, should get the correct data', () {
        final input = {
          'username': 'dane.mackier@filledstacks.com',
          'password': 'session-mate',
          'expiresInMins': 3600,
        };

        final streamInput = convertStringToUint8List(jsonEncode(input));
        final streamOutput = prepareBody(streamInput);

        final output = {
          'username': 29,
          'password': 12,
          'expiresInMins': 4,
        };

        expect(output, jsonDecode(convertUint8ListToString(streamOutput!)));
      });

      test('When called, should get the correct data', () {
        final input = {
          'username': 'xxxx.xxxxxxx@xxxxxxxxxxxx.xxx',
          'password': 'xxxxxxx-xxxx',
          'expiresInMins': 9999,
        };

        final streamInput = convertStringToUint8List(jsonEncode(input));
        final streamOutput = prepareBody(streamInput);

        final output = {
          'username': 29,
          'password': 12,
          'expiresInMins': 4,
        };

        expect(output, jsonDecode(convertUint8ListToString(streamOutput!)));
      });
    });

    group('prepareUrl -', () {
      test('When called, should get the correct data', () {
        final input = 'https://filledstacks.api';

        expect(input, prepareUrl(input));
      });

      test('When called, should get the correct data', () {
        final input = 'https://filledstacks.api?';

        expect(input, prepareUrl(input));
      });

      test('When called, should get the correct data', () {
        final input = 'https://filledstacks.api?password=?234?';

        final output = 'https://filledstacks.api?password=5';

        expect(output, prepareUrl(input));
      });

      test('When called, should get the correct data', () {
        final input =
            'https://filledstacks.api?email=dane@filledstacks.com&password=1234';

        final output = 'https://filledstacks.api?email=21&password=4';

        expect(output, prepareUrl(input));
      });
    });
  });
}
