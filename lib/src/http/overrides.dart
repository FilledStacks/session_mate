import 'dart:io' show HttpClient, HttpOverrides, SecurityContext;

import 'package:uuid/uuid.dart';

import 'client.dart';

class SessionMateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return SessionMateHttpClient(super.createHttpClient(context), Uuid().v4);
  }
}
