import 'dart:io' show HttpHeaders;
import 'dart:typed_data' show Uint8List;

import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/interceptor_service.dart';
import 'package:session_mate/src/utils/event_utils.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';

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

  final _interceptorService = locator<InterceptorService>();
  final _routeTracker = locator<SessionMateRouteTracker>();

  String get uid => _uid;

  void onError(Exception e) {
    _sendRequestEvent({}, '');

    _interceptorService.onEvent(
      ResponseEvent(
        uid: _uid,
        timeMs: _calcDurationTime(),
        code: 0,
        headers: {},
        error: e.toString(),
        body: null,
        view: _routeTracker.currentRoute,
        order: EventUtils.getEventOrder(),
      ),
    );
  }

  void addData(List<int> bytes) {
    data = Uint8List.fromList(bytes);
  }

  void sendRequestEvent(HttpHeaders headers, String host) => _sendRequestEvent(
        _headersToMap(headers),
        host,
      );

  void _sendRequestEvent(Map<String, String> headers, String host) {
    headers['host'] = host;

    _interceptorService.onEvent(RequestEvent(
      uid: _uid,
      url: _url,
      method: _method,
      headers: headers,
      body: data,
      view: _routeTracker.currentRoute,
      order: EventUtils.getEventOrder(),
    ));
  }

  void sendSuccessResponse(
    int statusCode,
    HttpHeaders headers,
    List<int> data,
  ) {
    _interceptorService.onEvent(ResponseEvent(
      uid: _uid,
      timeMs: _calcDurationTime(),
      code: statusCode,
      headers: _headersToMap(headers),
      error: null,
      body: Uint8List.fromList(data),
      view: _routeTracker.currentRoute,
      order: EventUtils.getEventOrder(),
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
