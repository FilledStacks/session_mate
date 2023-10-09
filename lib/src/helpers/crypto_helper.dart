import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:session_mate_core/session_mate_core.dart';

String hashEvent(RequestEvent event) {
  return sha256
      .convert(utf8.encode(jsonEncode(event.copyWith(
        uid: '',
        body: event.hasBody ? event.body : null,
        order: 0,
      ))))
      .toString();
}
