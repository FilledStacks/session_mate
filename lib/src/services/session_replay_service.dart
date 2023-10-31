import 'dart:io';

import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/setup_code.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionReplayService {
  /// Stores the hash of each request
  final Map<String, String> _requestsHashes = {};

  /// Stores the responses that were mocked under session recording
  final Map<String, ResponseEvent> _mockedResponses = {};

  RequestEvent? _currentEvent;

  // TODO: use only RequestEvent here
  void handleEvent(NetworkEvent event) {
    try {
      if (event is RequestEvent) {
        _currentEvent = event;
        _requestsHashes[event.uid] = hashEvent(event);
        logRequest(event);
      }
    } catch (e, s) {
      print('🔴 Error:${e.toString()} StackTrace:\n$s');
    }
  }

  void populateCache(List<NetworkEvent> events) {
    print(
      'SessionReplayService - populate ${events.length} mocked responses into cache',
    );

    for (var e in events) {
      _mockedResponses[(e as ResponseEvent).uid] = e;
    }
  }

  Future<void> handleMockRequest(HttpRequest request) async {
    try {
      // NOTE: what if we hash the request directly here to avoid using uid?

      final response = _mockedResponses[_requestsHashes[_currentEvent?.uid]];

      if (response != null) {
        request.response
          ..headers.host = response.headers['host']
          ..headers.contentType = stringToContentType(
            response.headers['content-type'],
          )
          ..write(response.body);
      }

      request.response.close();
    } catch (e) {
      print('$e');
    }
  }

  Future<List<int>> getSanitizedData(List<int> data, {String? uid}) async {
    if (kRecordUserInteractions || uid == null) return data;

    final response = _mockedResponses[_requestsHashes[uid]];

    if (response == null) return data;

    if (hasImageContentType(response)) return gPlaceHolder;

    return response.body ?? data;
  }
}
