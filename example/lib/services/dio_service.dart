import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example/app/app.logger.dart';

enum _HttpMethod { get, post, put, delete }

class DioService {
  final logger = getLogger('DioService');

  late final Dio _httpClient;

  DioService() {
    _httpClient = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: "https://rickandmortyapi.com/api",
      ),
    );
  }

  Future<String> getResources() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '',
    );

    if (response.statusCode != 200) return '';

    return """
      method: ${_HttpMethod.get}
      url: ${response.realUri}
      statusCode: ${response.statusCode}
      totalItems: ${response.data.length}
      items: ${response.data.keys.map((e) => e)}
    """;
  }

  Future<String> getCharacters() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '/character',
    );

    if (response.statusCode != 200) return '';

    final body = response.data['results'] as List;
    final items = body.take(3).map((e) => e["name"]);

    return """
      method: ${_HttpMethod.get}
      url: ${response.realUri}
      statusCode: ${response.statusCode}
      totalItems: ${response.data['info']['count']}
      items (0, 2): $items
    """;
  }

  Future<String> getLocations() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '/location',
    );

    if (response.statusCode != 200) return '';

    final body = response.data['results'] as List;
    final items = body.take(3).map((e) => e["name"]);

    return """
      method: ${_HttpMethod.get}
      url: ${response.realUri}
      statusCode: ${response.statusCode}
      totalItems: ${response.data['info']['count']}
      resources: ${response.data.keys.map((e) => e)}
      items (0, 2): $items
    """;
  }

  Future<String> getEpisodes() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '/episode',
    );

    if (response.statusCode != 200) return '';

    final body = response.data['results'] as List;
    final items = body.take(3).map((e) => e["name"]);

    return """
      method: ${_HttpMethod.get}
      url: ${response.realUri}
      statusCode: ${response.statusCode}
      totalItems: ${response.data['info']['count']}
      resources: ${response.data.keys.map((e) => e)}
      items (0, 2): $items
    """;
  }

  Future<Response> _makeHttpRequest({
    required _HttpMethod method,
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool verbose = false,
    bool verboseResponse = false,
  }) async {
    try {
      final response = await _sendRequest(
        method: method,
        path: path,
        queryParameters: queryParameters,
        body: body,
      );

      final statusText = 'Status Code: ${response.statusCode}';
      final responseText = 'Response Data: ${response.data}';

      if (verbose) {
        logger.v('$statusText${verboseResponse ? responseText : ''}');
      }

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown && e.error is SocketException) {
        logger.e(
          'This seems to be a network issue. Please check your network and try again.',
        );
        rethrow;
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        logger.e(
          'This seems to be a network issue. Please check your network and try again.',
        );
        rethrow;
      }

      logger.e(
        'A response error occurred. ${e.response?.statusCode}\nERROR: ${e.message}',
      );
      rethrow;
    } catch (e) {
      logger.e('Request to $path failed. Error details: $e');
      rethrow;
    }
  }

  Future<Response> _sendRequest({
    required _HttpMethod method,
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Response response;

    switch (method) {
      case _HttpMethod.post:
        response = await _httpClient.post(
          path,
          queryParameters: queryParameters,
          data: body,
        );
        break;
      case _HttpMethod.put:
        response = await _httpClient.put(
          path,
          queryParameters: queryParameters,
          data: body,
        );
        break;
      case _HttpMethod.delete:
        response = await _httpClient.delete(
          path,
          queryParameters: queryParameters,
        );
        break;
      case _HttpMethod.get:
      default:
        response = await _httpClient.get(
          path,
          queryParameters: queryParameters,
        );
    }

    return response;
  }
}
