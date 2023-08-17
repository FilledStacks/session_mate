import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/session_service.dart';

// import 'event_sender.dart';
import 'event_tracker.dart';
import 'response_wrapper.dart';

class HttpRequestWrapper implements HttpClientRequest {
  final HttpClientRequest _httpClientRequest;
  final HttpEventTracker _httpEventTracker;

  final _sessionService = locator<SessionService>();

  @override
  Encoding get encoding => _httpClientRequest.encoding;

  @override
  set encoding(Encoding value) => _httpClientRequest.encoding = value;

  @override
  int get contentLength => _httpClientRequest.contentLength;

  @override
  set contentLength(int value) => _httpClientRequest.contentLength = value;

  @override
  bool get bufferOutput => _httpClientRequest.bufferOutput;

  @override
  set bufferOutput(bool value) => _httpClientRequest.bufferOutput = value;

  @override
  bool get followRedirects => _httpClientRequest.followRedirects;

  @override
  set followRedirects(bool value) => _httpClientRequest.followRedirects = value;

  @override
  bool get persistentConnection => _httpClientRequest.persistentConnection;

  @override
  set persistentConnection(bool value) =>
      _httpClientRequest.persistentConnection = value;

  @override
  int get maxRedirects => _httpClientRequest.maxRedirects;

  @override
  set maxRedirects(int value) => _httpClientRequest.maxRedirects = value;

  HttpRequestWrapper(this._httpClientRequest, this._httpEventTracker);

  @override
  void add(List<int> data) {
    _httpEventTracker.addData(data);
    _httpClientRequest.add(data);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _httpClientRequest.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    final List<int> body = [];
    final StreamTransformer<List<int>, List<int>> streamTransformer =
        StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data);
      body.addAll(data);
    }, handleDone: (sink) {
      _httpEventTracker.addData(body);
      sink.close();
    });
    final Stream<List<int>> resultedStream = streamTransformer.bind(stream);
    return _httpClientRequest.addStream(resultedStream);
  }

  @override
  Future<HttpClientResponse> close() async {
    _httpEventTracker.sendRequestEvent(headers);

    final List<int> body = [];
    final HttpClientResponse response = await _httpClientRequest.close();

    return HttpResponseWrapper(
      response,
      response.transform(
        StreamTransformer.fromHandlers(handleData: (data, sink) {
          body.addAll(data);
        }, handleError: (error, stackTrace, sink) {
          print("HttpRequestWrapper :: ERROR RESPONSE $error $stackTrace");
        }, handleDone: (sink) async {
          // we need to send the response to session mate before waiting because
          // requestHandled we use the response uid to compare with request uid
          // and decide if should mock response or not.
          // NOTE: probably this solution has to be changed for a more advanced
          // solution that avoids conflicts when multiple requests are made at
          // the same time.
          _httpEventTracker.sendSuccessResponse(
            response.statusCode,
            response.headers,
            body,
          );

          // while (EventSender.requestHandled) {
          //   await Future.delayed(Duration(microseconds: 100));
          // }

          // sink.add(await EventSender.getResponseData(body));
          sink.add(await _sessionService.getResponseData(body));
          sink.close();
        }),
      ),
    );
  }

  @override
  HttpConnectionInfo? get connectionInfo => _httpClientRequest.connectionInfo;

  @override
  List<Cookie> get cookies => _httpClientRequest.cookies;

  @override
  Future<HttpClientResponse> get done => _httpClientRequest.done;

  @override
  Future flush() => _httpClientRequest.flush();

  @override
  HttpHeaders get headers => _httpClientRequest.headers;

  @override
  String get method => _httpClientRequest.method;

  @override
  Uri get uri => _httpClientRequest.uri;

  @override
  void write(Object? obj) {
    _httpClientRequest.write(obj);
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    _httpClientRequest.writeAll(objects, separator);
  }

  @override
  void writeCharCode(int charCode) {
    _httpClientRequest.writeCharCode(charCode);
  }

  @override
  void writeln([Object? obj = ""]) {
    _httpClientRequest.writeln(obj);
  }

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    _httpClientRequest.abort(exception, stackTrace);
  }
}
