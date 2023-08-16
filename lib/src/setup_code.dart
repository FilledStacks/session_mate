import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_storage_service.dart';

import 'app/locator_setup.dart';

Future<void> setupSessionMate() async {
  enableFlutterDriverExtension(
    handler: (message) async {
      final driverCommunicationService = locator<DriverCommunicationService>();
      return driverCommunicationService.waitForInteractions();
    },
  );

  HttpOverrides.global = SessionMateHttpOverrides();

  // Here we can setup our locator since we are going to be using services as well
  await setupLocator();

  print('================== Sessions on device =================');
  final hiveService = locator<HiveStorageService>();
  print('Sessions: ${hiveService.getSessions().length}');
  print('================== END SESSION DETAILS ==================');
}
