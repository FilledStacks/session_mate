import 'dart:typed_data';

import 'event_sender.dart' show Event;

class HttpRequestEvent extends Event {
  final String uid;
  final String url;
  final String method;
  final Map<String, String> headers;
  final Uint8List? body;

  @override
  String get name => "http-request";

  HttpRequestEvent(this.uid, this.url, this.method, this.headers, this.body);

  @override
  Map<String, dynamic> get arguments => {
        "uid": uid,
        "url": url,
        "method": method,
        "headers": headers,
        "body": body
      };
}
