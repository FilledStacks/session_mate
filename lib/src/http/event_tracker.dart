import 'dart:io' show HttpHeaders;
import 'dart:typed_data' show Uint8List;

import 'event_sender.dart' show EventSender;
import 'request_event.dart';
import 'response_event.dart';

class HttpEventTracker {
  final String _url;
  final String _uid;
  final String _method;
  final int _startTime;
  Uint8List? data;

  HttpEventTracker.fromUri(this._method, this._uid, Uri uri)
      : _url = uri.toString(),
        _startTime = DateTime.now().millisecondsSinceEpoch;

  HttpEventTracker.fromHost(
    this._method,
    this._uid,
    String host,
    int port,
    String path,
  )   : _url = Uri(
          scheme: "http",
          host: host,
          port: port,
          path: path,
        ).toString(),
        _startTime = DateTime.now().millisecondsSinceEpoch;

  void onError(Exception e) {
    _sendRequestEvent({});

    EventSender.sendEvent(
      HttpResponseEvent(_uid, _calcDurationTime(), 0, {}, e.toString(), null),
    );
  }

  void addData(List<int> bytes) {
    data = Uint8List.fromList(bytes);
  }

  void sendRequestEvent(HttpHeaders headers) => _sendRequestEvent(
        _headersToMap(headers),
      );

  void _sendRequestEvent(Map<String, String> headers) {
    EventSender.sendEvent(HttpRequestEvent(_uid, _url, _method, headers, data));
  }

  void sendSuccessResponse(
    int statusCode,
    HttpHeaders headers,
    List<int> data,
  ) {
    EventSender.sendEvent(HttpResponseEvent(
      _uid,
      _calcDurationTime(),
      statusCode,
      _headersToMap(headers),
      null,
      Uint8List.fromList(data),
    ));
  }

  int _calcDurationTime() {
    return DateTime.now().millisecondsSinceEpoch - _startTime;
  }

  Map<String, String> _headersToMap(HttpHeaders httpHeaders) {
    final Map<String, String> headers = {};

    httpHeaders.forEach((header, values) {
      headers[header] = values.first;
    });

    return headers;
  }
}
