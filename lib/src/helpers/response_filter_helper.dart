import 'dart:io';
import 'dart:typed_data';

import 'package:session_mate_core/session_mate_core.dart';

bool hasImageContentType(ResponseEvent event) {
  if (!event.headers.containsKey('content-type')) return false;

  if (!(event.headers['content-type']?.contains('image') ?? false)) {
    return false;
  }

  return true;
}

bool hasJsonContentType(ResponseEvent event) {
  if (!event.headers.containsKey('content-type')) return false;

  if (!(event.headers['content-type']?.contains('json') ?? false)) {
    return false;
  }

  return true;
}

bool hasXmlContentType(ResponseEvent event) {
  if (!event.headers.containsKey('content-type')) return false;

  if (!(event.headers['content-type']?.contains('xml') ?? false)) {
    return false;
  }

  return true;
}

bool hasMediaContentType(ResponseEvent event) {
  if (!event.headers.containsKey('content-type')) return false;

  if (event.headers['content-type']!.contains('audio')) return true;

  if (event.headers['content-type']!.contains('image')) return true;

  if (event.headers['content-type']!.contains('video')) return true;

  return false;
}

bool hasSupportedContentType(ResponseEvent event) {
  if (hasJsonContentType(event)) return true;

  return false;
}

String toReadableString(Uint8List? data) {
  if (data == null) return '';

  if (data.isEmpty) return '';

  try {
    return String.fromCharCodes(data);
  } catch (e) {
    print(
      '🔴 An error occurs converting the data bytes to readable. ${e.toString()}',
    );

    return '';
  }
}

ContentType stringToContentType(String? content) {
  if (content == null) return ContentType('application', 'unknown');

  try {
    final contentType = content.split(';');
    final mainType = contentType[0].split('/');

    String? charset;
    Map<String, String?> parameters = {};
    List<String?> paramList = [];

    for (var p in contentType.indexed) {
      if (p.$1 == 0) continue;

      paramList = p.$2.split('=');

      if (paramList[0] == null || paramList[0]!.isEmpty) continue;

      if (paramList[0] == 'charset') charset = paramList[0];

      parameters.addAll({paramList[0]!.trim(): paramList[1]?.trim()});
    }

    return ContentType(
      mainType[0].trim(),
      mainType[1].trim(),
      charset: charset,
      parameters: parameters,
    );
  } catch (e) {
    print('🔴 Error:${e.toString()}');
    return ContentType('application', 'unknown');
  }
}
