import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:session_mate_core/session_mate_core.dart';

String hashEvent(RequestEvent event) {
  return sha256
      .convert(utf8.encode(jsonEncode({
        'url': prepareUrl(event.url),
        'method': event.method,
        'body': prepareBody(event.body),
      })))
      .toString();
}

@visibleForTesting
String prepareUrl(String url) {
  final queryStarts = url.indexOf('?');

  if (queryStarts == -1) return url;

  final query = url.substring(queryStarts);
  final queryParameters = query.split('&');

  String modifiedQuery = '';
  for (var param in queryParameters) {
    final keyValue = param.split('=');
    modifiedQuery = '$modifiedQuery${keyValue[0]}=${keyValue[1].length}';
  }

  return '${url.substring(0, queryStarts)}$modifiedQuery';
}

@visibleForTesting
Uint8List? prepareBody(Uint8List? body) {
  if (body == null || body.isEmpty) return null;

  Map<String, dynamic> modifiedBody = {};
  final Map<String, dynamic> data = jsonDecode(convertUint8ListToString(body));

  for (var item in data.entries) {
    modifiedBody[item.key] = item.value.toString().length;
  }

  return convertStringToUint8List(jsonEncode(modifiedBody));
}

Uint8List convertStringToUint8List(String str) {
  final List<int> codeUnits = str.codeUnits;
  final Uint8List unit8List = Uint8List.fromList(codeUnits);

  return unit8List;
}

String convertUint8ListToString(Uint8List uint8list) {
  return String.fromCharCodes(uint8list);
}
