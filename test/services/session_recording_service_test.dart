import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../data/http/responses/html.dart';
import '../data/http/responses/image_jpeg.dart';
import '../data/http/responses/json.dart';
import '../data/http/responses/xml.dart';
import '../helpers/test_helpers.dart';

void main() {
  SessionRecordingService getService() => SessionRecordingService();

  group('SessionRecordingServiceTest -', () {
    setUpAll(() => registerServices());

    final testResponseEvent = ResponseEvent(
      uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
      timeMs: 884,
      code: 200,
      headers: {
        'connection': 'keep-alive',
        'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
        'transfer-encoding': 'chunked',
        'content-encoding': 'gzip',
        'vary': 'Origin',
        'x-runtime': '0.001136',
        'content-type': 'application/json; charset=UTF-8',
        'server': 'nginx/1.18.0 (Ubuntu)',
        'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
      },
      body: convertStringToUint8List(jsonResponse),
      view: '/books-list-view',
      order: 1698679750044,
    );

    group('avoidDataMasking -', () {
      test('when called and data masking is disabled, should return true', () {
        getAndRegisterConfigurationService(dataMaskingEnabled: false);

        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent);

        expect(output, isTrue);
      });

      test('when called with text/html content type, should return true', () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'text/html; charset=UTF-8',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: convertStringToUint8List(htmlResponse),
        ));

        expect(output, isTrue);
      });

      test('when called with application/xml content type, should return true',
          () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'application/xml; charset=UTF-8',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: convertStringToUint8List(xmlResponse),
        ));

        expect(output, isTrue);
      });

      test(
          'when called with application/octet-stream content type, should return true',
          () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'application/octet-stream',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
        ));

        expect(output, isTrue);
      });

      test('when called with image/jpeg content type, should return true', () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'image/jpeg',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: Uint8List.fromList(imageJpegResponse),
        ));

        expect(output, isTrue);
      });

      test('when called with image/gif content type, should return true', () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'image/gif',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
        ));

        expect(output, isTrue);
      });

      test('when called with image/png content type, should return true', () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'image/png',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
        ));

        expect(output, isTrue);
      });

      test(
          'when called with application/json content type, should return false',
          () {
        getAndRegisterConfigurationService(dataMaskingEnabled: true);
        final service = getService();

        final output = service.avoidDataMasking(testResponseEvent);

        expect(output, isFalse);
      });
    });

    group('handleEvent -', () {
      test(
          'When called with response and no hash in _requests, should NOT do anything',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService();
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        service.handleEvent(testResponseEvent);

        verifyZeroInteractions(dataMaskingService);
        verifyZeroInteractions(sessionService);
      });

      test(
          'When called with response having application/json content type, should mask response',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService(
          maskedResponseMap: testResponseEvent.toJson(),
        );
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        final request = RequestEvent(
          uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
          url: 'https://thetestrequest.com/authors',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'thetestrequest.com'
          },
          view: '/books-list-view',
          order: 1698677510044,
        );

        service.handleEvent(request);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.checkForEnterPressed(any));
        verifyNoMoreInteractions(sessionService);

        service.handleEvent(testResponseEvent);

        verify(dataMaskingService.handle(any));
        verify(sessionService.addEvent(any));
      });

      test(
          'When called with response having text/html content type, should NOT mask response',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService();
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        final request = RequestEvent(
          uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
          url: 'https://thetestrequest.com/authors',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'thetestrequest.com'
          },
          view: '/books-list-view',
          order: 1698677510044,
        );

        service.handleEvent(request);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.checkForEnterPressed(any));
        verifyNoMoreInteractions(sessionService);

        service.handleEvent(testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'text/html; charset=UTF-8',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: convertStringToUint8List(htmlResponse),
        ));

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.addEvent(any));
      });

      test(
          'When called with response having application/xml content type, should NOT mask response',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService();
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        final request = RequestEvent(
          uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
          url: 'https://thetestrequest.com/authors',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'thetestrequest.com'
          },
          view: '/books-list-view',
          order: 1698677510044,
        );

        service.handleEvent(request);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.checkForEnterPressed(any));
        verifyNoMoreInteractions(sessionService);

        final response = testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'application/xml',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: convertStringToUint8List(xmlResponse),
        );

        service.handleEvent(response);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.addEvent(response.copyWith(
          uid:
              '19e8d0de913a1242a85f6b57e30fbf7027700484c30b3ce994d1e197d8c3015d',
        )));
      });

      test(
          'When called with response having image/jpeg content type, should NOT save response body',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService();
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        final request = RequestEvent(
          uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
          url: 'https://thetestrequest.com/authors',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'thetestrequest.com'
          },
          view: '/books-list-view',
          order: 1698677510044,
        );

        service.handleEvent(request);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.checkForEnterPressed(any));
        verifyNoMoreInteractions(sessionService);

        final response = testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'image/jpeg',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: Uint8List.fromList(imageJpegResponse),
        );

        service.handleEvent(response);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.addEvent(response.copyWith(
          uid:
              '19e8d0de913a1242a85f6b57e30fbf7027700484c30b3ce994d1e197d8c3015d',
          body: null,
        )));
      });

      test(
          'When called with response having application/octet-stream content type, should NOT mask response',
          () {
        final dataMaskingService = getAndRegisterDataMaskingService();
        final sessionService = getAndRegisterSessionService();
        final service = getService();

        final request = RequestEvent(
          uid: '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
          url: 'https://thetestrequest.com/authors',
          method: 'GET',
          headers: {
            'user-agent': 'Dart/3.1 (dart:io)',
            'accept-encoding': 'gzip',
            'content-length': '0',
            'host': 'thetestrequest.com'
          },
          view: '/books-list-view',
          order: 1698677510044,
        );

        service.handleEvent(request);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.checkForEnterPressed(any));
        verifyNoMoreInteractions(sessionService);

        final response = testResponseEvent.copyWith(
          headers: {
            'connection': 'keep-alive',
            'date': 'Tue, 31 Oct 2023 02:38:44 GMT',
            'transfer-encoding': 'chunked',
            'content-encoding': 'gzip',
            'vary': 'Origin',
            'x-runtime': '0.001136',
            'content-type': 'application/octet-stream',
            'server': 'nginx/1.18.0 (Ubuntu)',
            'x-request-id': '2321f27b-6cc7-450c-b8aa-cdd8dc6562fa'
          },
          body: Uint8List.fromList(imageJpegResponse),
        );

        service.handleEvent(response);

        verifyZeroInteractions(dataMaskingService);
        verify(sessionService.addEvent(any));
      });
    });
  });
}
