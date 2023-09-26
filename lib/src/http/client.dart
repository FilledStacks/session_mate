import 'dart:async' show Future;
import 'dart:io';

import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';

import 'event_tracker.dart';
import 'request_wrapper.dart';

class SessionMateHttpClient implements HttpClient {
  final HttpClient _httpClient;
  final String Function() _uidGenerator;

  SessionMateHttpClient(this._httpClient, this._uidGenerator);

  @override
  get autoUncompress => _httpClient.autoUncompress;

  @override
  set autoUncompress(value) {
    _httpClient.autoUncompress = value;
  }

  @override
  get connectionTimeout => _httpClient.connectionTimeout;

  @override
  set connectionTimeout(value) {
    _httpClient.connectionTimeout = value;
  }

  @override
  get idleTimeout => _httpClient.idleTimeout;

  @override
  set idleTimeout(value) {
    _httpClient.idleTimeout = value;
  }

  @override
  get maxConnectionsPerHost => _httpClient.maxConnectionsPerHost;

  @override
  set maxConnectionsPerHost(value) {
    _httpClient.maxConnectionsPerHost = value;
  }

  @override
  get userAgent => _httpClient.userAgent;

  @override
  set userAgent(value) {
    _httpClient.userAgent = value;
  }

  @override
  void addCredentials(
    Uri url,
    String realm,
    HttpClientCredentials credentials,
  ) {
    return _httpClient.addCredentials(url, realm, credentials);
  }

  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    HttpClientCredentials credentials,
  ) {
    return _httpClient.addProxyCredentials(host, port, realm, credentials);
  }

  @override
  set authenticate(value) {
    _httpClient.authenticate = value;
  }

  @override
  set authenticateProxy(value) {
    _httpClient.authenticateProxy = value;
  }

  @override
  set badCertificateCallback(value) {
    _httpClient.badCertificateCallback = value;
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    _httpClient.findProxy = f;
  }

  @override
  void close({bool force = false}) {
    return _httpClient.close(force: force);
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) =>
      open("delete", host, port, path);

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) => openUrl("delete", url);

  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      open("get", host, port, path);

  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl("get", url);

  @override
  Future<HttpClientRequest> head(String host, int port, String path) =>
      open("head", host, port, path);

  @override
  Future<HttpClientRequest> headUrl(Uri url) => openUrl("head", url);

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) =>
      open("patch", host, port, path);

  @override
  Future<HttpClientRequest> patchUrl(Uri url) => openUrl("patch", url);

  @override
  Future<HttpClientRequest> post(String host, int port, String path) =>
      open("post", host, port, path);

  @override
  Future<HttpClientRequest> postUrl(Uri url) => openUrl("post", url);

  @override
  Future<HttpClientRequest> put(String host, int port, String path) =>
      open("put", host, port, path);

  @override
  Future<HttpClientRequest> putUrl(Uri url) => openUrl("put", url);

  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) {
    // TODO: implement similar functionality as openUrl method for local server
    final tracker = HttpEventTracker.fromHost(
      method,
      _uidGenerator(),
      host,
      port,
      path,
    );
    return _httpClient.open(method, host, port, path).then((request) {
      return HttpRequestWrapper(request, tracker);
    }).onError((Exception error, stackTrace) {
      tracker.onError(error);
      return Future.error(error, stackTrace);
    });
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async {
    // NOTE: what if the request is hashed here ??
    final tracker = HttpEventTracker.fromUri(method, _uidGenerator(), url);

    Uri? mockedUrl;
    if (!kRecordUserInteractions) {
      mockedUrl = url.replace(
        scheme: kLocalServerScheme,
        host: kLocalServerHost,
        port: locator<ConfigurationService>().listeningPort,
      );
    }

    // NOTE: Proper place to await any request / requestWrapper task

    return _httpClient.openUrl(method, mockedUrl ?? url).then((request) {
      if (!kRecordUserInteractions) {
        request.headers.host = url.host;
      }

      return HttpRequestWrapper(request, tracker);
    }).onError((Exception error, stackTrace) {
      tracker.onError(error);
      return Future.error(error, stackTrace);
    });
  }

  @override
  set connectionFactory(
          Future<ConnectionTask<Socket>> Function(
                  Uri url, String? proxyHost, int? proxyPort)?
              f) =>
      _httpClient.connectionFactory = f;

  @override
  set keyLog(Function(String line)? callback) => _httpClient.keyLog = callback;
}
