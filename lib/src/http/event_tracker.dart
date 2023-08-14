import 'dart:io' show HttpHeaders;
import 'dart:typed_data' show Uint8List;

import 'package:session_mate_core/session_mate_core.dart';

import 'event_sender.dart' show EventSender;

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
      ResponseEvent(
        uid: _uid,
        timeMs: _calcDurationTime(),
        code: 0,
        headers: {},
        error: e.toString(),
        body: null,
      ),
    );
  }

  void addData(List<int> bytes) {
    data = Uint8List.fromList(bytes);
  }

  void sendRequestEvent(HttpHeaders headers) => _sendRequestEvent(
        _headersToMap(headers),
      );

  void _sendRequestEvent(Map<String, String> headers) {
    EventSender.sendEvent(RequestEvent(
      uid: _uid,
      url: _url,
      method: _method,
      headers: headers,
      body: data,
    ));
  }

  void sendSuccessResponse(
    int statusCode,
    HttpHeaders headers,
    List<int> data,
  ) {
    EventSender.sendEvent(ResponseEvent(
      uid: _uid,
      timeMs: _calcDurationTime(),
      code: statusCode,
      headers: _headersToMap(headers),
      error: null,
      body: Uint8List.fromList(data),
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
