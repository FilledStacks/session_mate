import 'dart:io';

import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionReplayService {
  /// Stores the hash of each request
  final Map<String, String> _requestsHashes = {};

  /// Stores the responses that were masked under session recording
  final Map<String, ResponseEvent> _maskedResponses = {};

  RequestEvent? _currentEvent;

  // TODO: use only RequestEvent here
  void handleEvent(NetworkEvent event) {
    if (event is RequestEvent) {
      _currentEvent = event;
      _requestsHashes[event.uid] = hashEvent(event);
      print('🟡 uid:${event.uid} hash:${_requestsHashes[event.uid]}');
    }
  }

  void populateCache(List<NetworkEvent> events) {
    print(
      'SessionReplayService - populate ${events.length} masked responses into cache',
    );

    for (var e in events) {
      _maskedResponses[(e as ResponseEvent).uid] = e;
    }

    print('🟣 MASKED');
    _maskedResponses.forEach((key, value) {
      print('🟣 hash:$key response:${value.toJson()}');
    });
  }

  Future<void> handleMockRequest(HttpRequest request) async {
    try {
      // NOTE: what if we hash the request directly here to avoid using uid?

      print(
          '🤡 - handleMockRequest - uri:${request.uri} headers:${request.headers}');

      final response = _maskedResponses[_requestsHashes[_currentEvent?.uid]];

      if (response != null) {
        request.response
          ..headers.host = response.headers['host']
          ..write(response.body);
      }

      request.response.close();
    } catch (e) {
      print('$e');
    }
  }

  Future<List<int>> getSanitizedData(List<int> data, {String? uid}) async {
    print('🤡 - getSanitizedData - uid:$uid data:$data');
    if (kRecordUserInteractions || uid == null) return data;

    final response = _maskedResponses[_requestsHashes[uid]];

    print('🤡 - getSanitizedData - response:${response?.toJson()} ');

    if (response == null) return data;

    if (hasImageContentType(response)) return gPlaceHolder;

    return response.body ?? data;
  }
}
