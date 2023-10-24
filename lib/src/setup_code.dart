import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/src/http/overrides.dart';
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
  } else if (kReplaySession) {
    enableFlutterDriverExtension(
      handler: (instruction) async {
        return locator<DriverCommunicationService>().handleInstruction(
          instruction,
        );
      },
    );
  }

  await setupLocator();

  if (!kRunningIntegrationTest) {
    HttpOverrides.global = SessionMateHttpOverrides();
    if (!kRecordUserInteractions) {
      HttpServer.bind(InternetAddress.loopbackIPv4, 0)
          .then((HttpServer server) {
        print('📻 listening on ${server.address}, port ${server.port}');
        locator<ConfigurationService>().setValues(listeningPort: server.port);
        server.listen((request) {
          locator<SessionReplayService>().handleMockRequest(request);
        });
      });

      // NOTE: perhaps we can listen to session_mate_cli to close the server,
      // otherwise, is going to be closed when the app is killed.

      final bytes = await rootBundle.load(
        'packages/session_mate/assets/images/placeholder.png',
      );
      // globalPlaceHolder = base64.encode(bytes.buffer.asUint8List());
      globalPlaceHolder = bytes.buffer.asUint8List();
    }
  }
}
