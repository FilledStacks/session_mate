import 'dart:io';
import 'dart:typed_data';

import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

final _configurationService = locator<ConfigurationService>();

void logRawRequest({
  required Uri uri,
  required String method,
  required HttpHeaders headers,
  Uint8List? body,
}) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: HttpRequest 🌎 -------');
  print('Uri:$uri');
  print('Method:$method');
  print('Headers:$headers');
  print('Body: ${toReadableString(body)}');
  print('-------------------------------------------------------');
  print('');
}

void logRawResponse({
  required Uri uri,
  required String method,
  required int statusCode,
  required HttpHeaders headers,
  Uint8List? body,
}) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: HttpResponse 🌍 -------');
  print('Uri: $uri');
  print('Method: $method');
  print('StatusCode: $statusCode');
  print('Headers: $headers');
  print('Body: ${toReadableString(body)}');
  print('-------------------------------------------------------');
  print('');
}

void logRequest(RequestEvent event) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: Request 🔼 -------');
  print(event.toJson());
  print('---------------------------------------------------');
  print('');
}

void logResponse(ResponseEvent event) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: ResponseEvent 🔽 -------');
  if (hasJsonContentType(event) || hasXmlContentType(event)) {
    print(event.toJson());
    return;
  }

  print('Content Type neither JSON nor XML');
  print('--------------------------------------------------------');
  print('');
}

void logSession(Session session) {
  if (!_configurationService.logNetworkData) return;

  final uiEvents = session.events.whereType<UIEvent>();
  final uiEventsDetails =
      uiEvents.map((e) => 'Type:${e.type}, View:${e.view}').toList();
  final networkEvents = session.events.whereType<NetworkEvent>();

  print('');
  print('------- Session Details 📥 -------');
  print('Id: ${session.id}');
  print('UI Events: ${uiEvents.length}');
  for (var e in uiEventsDetails) {
    print('\n   $e');
  }
  print('Response Events: ${networkEvents.length}');
  print('Views: ${session.views}');
  print('Created At: ${session.createdAt}');
  print('---------------------------------');
  print('');
}
