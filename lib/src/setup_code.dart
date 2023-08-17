import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';

import 'app/locator_setup.dart';

Future<void> setupSessionMate() async {
  if (kRecordUserInteractions) {
    WidgetsFlutterBinding.ensureInitialized();
  } else {
    enableFlutterDriverExtension(
      handler: (message) async {
        final driverCommunicationService =
            locator<DriverCommunicationService>();
        return driverCommunicationService.waitForInteractions();
      },
    );
  }

  HttpOverrides.global = SessionMateHttpOverrides();

  // Here we can setup our locator since we are going to be using services as well
  await setupLocator();

  print('================== Sessions on device =================');
  final hiveService = locator<HiveService>();
  final sessions = hiveService.getSessions();
  for (var s in sessions) {
    print('session: ${s.id}');
    for (var e in s.events) {
      print('event:$e');
    }
  }
  print('================== END SESSION DETAILS ==================');
}
