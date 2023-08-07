import 'dart:io' show HttpClient, HttpOverrides, SecurityContext;

import 'package:uuid/uuid.dart';

import 'client.dart';

class SessionMateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final uuid = Uuid();
    return SessionMateHttpClient(super.createHttpClient(context), uuid.v4);
  }
}
