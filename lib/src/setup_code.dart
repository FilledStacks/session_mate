import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';

import 'app/locator_setup.dart';

final gPlaceHolder = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAFUlEQVR42mP8z8BQz0AEYBxVSF+FABJADveWkH6oAAAAAElFTkSuQmCC',
);

late Uint8List globalPlaceHolder;

Future<void> setupSessionMate() async {
  if (kRecordUserInteractions) {
    WidgetsFlutterBinding.ensureInitialized();
  } else {
    enableFlutterDriverExtension(
      handler: (message) async {
        return locator<DriverCommunicationService>().waitForInteractions();
      },
    );
  }

  HttpOverrides.global = SessionMateHttpOverrides();

  // Here we can setup our locator since we are going to be using services as well
  await setupLocator();

  final bytes = await rootBundle.load(
    'packages/session_mate/assets/images/placeholder.png',
  );
  // globalPlaceHolder = base64.encode(bytes.buffer.asUint8List());
  globalPlaceHolder = bytes.buffer.asUint8List();

  if (!kRecordUserInteractions) {
    HttpServer.bind(InternetAddress.loopbackIPv4, 0).then((HttpServer server) {
      print('📻 listening on ${server.address}, port ${server.port}');
      locator<ConfigurationService>().setValues(listeningPort: server.port);
      server.listen((request) {
        locator<SessionReplayService>().handleMockRequest(request);
      });
    });

    // NOTE: perhaps we can listen to session_mate_cli to close the server,
    // otherwise, is going to be closed when the app is killed.
  }
}
