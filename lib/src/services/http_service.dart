import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/exceptions/custom_message_exception.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

const _baseUrl = String.fromEnvironment(
  'SESSION_MATE_BASE_URL',
  defaultValue: _useFirebaseEmulator
      ? 'http://10.0.2.2:5001/sessionmate-93c0e/us-central1'
      : 'https://us-central1-sessionmate-93c0e.cloudfunctions.net',
);
const _useFirebaseEmulator =
    bool.fromEnvironment('SESSION_MATE_USE_FIREBASE_EMULATOR');
const _idToken = String.fromEnvironment('SESSION_MATE_ID_TOKEN');

enum _HttpMethod {
  get,
  post,
  put,
  delete,
}

class HttpService {
  late final Dio _httpClient;

  final _configurationService = locator<ConfigurationService>();
  final _nativeInformationService = locator<NativeInformationService>();

  HttpService() {
    _httpClient = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: _baseUrl,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $_idToken',
        },
      ),
    );

    _httpClient.interceptors.add(TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        printRequestData: true,
        printResponseData: false,
      ),
    ));
  }

  Future<List<Session>> getSessions() async {
    final response = await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '/sessions-api/getSessions',
      queryParameteres: {
        'apiKey': _configurationService.apiKey,
        'appId': _nativeInformationService.appId,
      },
    );

    if (response?.statusCode == 401) {
      logText(
        '🔴 ERROR CODE:${response?.data['code']}, MESSAGE:${response?.data['message']}',
      );
      throw CustomMessageException(
        '${response?.statusMessage}\n\nPlease login to CLI to see your sessions.',
      );
    }

    if (response?.statusCode != 200) {
      throw CustomMessageException(response?.statusMessage);
    }

    final body = response?.data as List<dynamic>;
    return body
        .map((e) => Session.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> saveSession({required Session session}) async {
    logText('save session');
    final sessionBody = SessionPostRequest.fromSession(
      session: session,
      appId: _nativeInformationService.appId,
      appVersion: _nativeInformationService.appVersion,
      osVersion: _nativeInformationService.osVersion,
      platform: _nativeInformationService.platform,
      userId: _nativeInformationService.uniqueIdentifier,
    );

    logText(jsonEncode(sessionBody.toJson()));

    final response = await _makeHttpRequest(
      method: _HttpMethod.post,
      path: '/sessions-api/createSession',
      queryParameteres: {
        'apiKey': _configurationService.apiKey,
        'appId': _nativeInformationService.appId,
      },
      body: sessionBody.toJson(),
    );
    return response != null;
  }

  Future<bool> deleteSessions() async {
    logText('delete sessions');

    final response = await _makeHttpRequest(
      method: _HttpMethod.delete,
      path: '/sessions-api/deleteSessions',
      queryParameteres: {
        'apiKey': _configurationService.apiKey,
        'appId': _nativeInformationService.appId,
      },
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
      logText('🔴 DioError: $e');
      throw CustomMessageException(e.message);
    } catch (e) {
      logText('🔴 HttpService exception: $e');
    }

    return response;
  }
}
