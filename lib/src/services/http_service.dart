import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

enum _HttpMethod {
  get,
  post,
  put,
  delete,
}

class HttpService {
  final _logger = getLogger('HttpService');
  late final Dio _httpClient;

  final _configurationService = locator<ConfigurationService>();
  final _nativeInformationService = locator<NativeInformationService>();

  HttpService() {
    _httpClient = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: 'https://us-central1-sessionmate-93c0e.cloudfunctions.net/',
      ),
    );

    _httpClient.interceptors.add(TalkerDioLogger(
      settings: TalkerDioLoggerSettings(),
    ));
  }

  Future<List<Session>> getSessions() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: 'sessions-api/getSessions',
      queryParameteres: {
        'apiKey': _configurationService.apiKey,
        'appId': _nativeInformationService.appId,
      },
    );

    if (response?.statusCode == 200) {
      final body = jsonDecode(response?.data) as List<dynamic>;
      return body
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  Future<bool> saveSession({required Session session}) async {
    _logger.v('save session');
    final sessionBody = SessionPostRequest.fromSession(
      session: session,
      appId: _nativeInformationService.appId,
      appVersion: _nativeInformationService.appVersion,
      osVersion: _nativeInformationService.osVersion,
      platform: _nativeInformationService.platform,
      userId: _nativeInformationService.uniqueIdentifier,
    );

    final response = await _makeHttpRequest(
      method: _HttpMethod.post,
      path: 'sessions-api/createSession',
      queryParameteres: {
        'apiKey': _configurationService.apiKey,
        'appId': _nativeInformationService.appId,
      },
      body: sessionBody.toJson(),
    );
    return response != null;
  }

  Future<Response?> _makeHttpRequest({
    required _HttpMethod method,
    required String path,
    Map<String, dynamic> queryParameteres = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Response? response;
    final requestOptions = Options(
      // headers: await _getHeaders(),
      // We don't throw exceptions for anything under 500
      // we need to handle it
      validateStatus: (status) =>
          (status ?? 500) < 500 || (status ?? 500) == 505,
    );
    try {
      switch (method) {
        case _HttpMethod.post:
          response = await _httpClient.post(
            path,
            queryParameters: queryParameteres,
            data: body,
            options: requestOptions,
          );
          break;
        case _HttpMethod.put:
          response = await _httpClient.put(
            path,
            queryParameters: queryParameteres,
            data: body,
            options: requestOptions,
          );
          break;
        case _HttpMethod.delete:
          response = await _httpClient.delete(
            path,
            queryParameters: queryParameteres,
            options: requestOptions,
          );
          break;
        case _HttpMethod.get:
        default:
          response = await _httpClient.get(
            path,
            queryParameters: queryParameteres,
            options: requestOptions,
          );
      }
    } on DioException catch (e) {
      _logger.e('DioError: $e');
    } catch (e) {
      _logger.e('HttpService exception: $e');
    }

    return response;
  }
}
