import 'package:flutter_driver/driver_extension.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';

import 'app/locator_setup.dart';

Future<void> setupSessionMate() async {
  // Here we can setup our locator since we are going to be using services as well
  await setupLocator();

  enableFlutterDriverExtension(
    handler: (message) async {
      final driverCommunicationService = locator<DriverCommunicationService>();
      return driverCommunicationService.waitForInteractions();
    },
  );
}
