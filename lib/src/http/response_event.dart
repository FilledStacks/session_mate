import 'dart:typed_data';

import 'event_sender.dart' show Event;

class HttpResponseEvent extends Event {
  final String uid;
  final int timeMs;
  final int code;
  final Map<String, String> headers;
  final String? error;
  final Uint8List? body;

  HttpResponseEvent(
    this.uid,
    this.timeMs,
    this.code,
    this.headers,
    this.error,
    this.body,
  );

  @override
  String get name => "http-response";

  @override
  Map<String, dynamic> get arguments => {
        "uid": uid,
        "code": code,
        "headers": headers,
        "error": error,
        "body": body,
        "tookMs": timeMs
      };

  @override
  String toString() => """
      UID: $uid
      StatusCode: $code
      Headers: $headers
      Error: $error
      Took: $timeMs ms
      Body: $body
    """;
}
