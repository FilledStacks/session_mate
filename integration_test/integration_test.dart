import 'package:flutter_test/flutter_test.dart';

import 'integration.backend.sessions.dart';
import 'integration.local.sessions.dart';
import 'integration_setup.dart';

Future<void> main() async {
  await setupIntegrationTests();

  group('Session Mate Integration Tests -', () {
    registerTestKickoff();

    registerBackendSessionTests();
    registerLocalSessionTests();
  });
}
