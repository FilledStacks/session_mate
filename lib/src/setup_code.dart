import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/src/http/overrides.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';

import 'app/locator_setup.dart';

Future<void> setupSessionMate({bool enableNetworkInterceptor = true}) async {
  if (kRecordSession) {
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

  if (kRunningIntegrationTest) return;

  if (!enableNetworkInterceptor) return;

  HttpOverrides.global = SessionMateHttpOverrides();

  if (kRecordSession) return;

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
