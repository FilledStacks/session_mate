import 'package:flutter_test/flutter_test.dart';

import 'integration.backend.sessions.dart';
import 'integration.local.sessions.dart';
import 'integration.ui.widget_finder.dart';
import 'integration_setup.dart';

const _kRunBackendTests =
    bool.fromEnvironment('SESSION_MATE_INTEGRATION_TEST_BACKEND_ONLY');
const _kRunLocalTests =
    bool.fromEnvironment('SESSION_MATE_INTEGRATION_TEST_LOCAL_ONLY');
const _kRunUITests =
    bool.fromEnvironment('SESSION_MATE_INTEGRATION_TEST_UI_ONLY');

const bool _kRunAllTests =
    !_kRunBackendTests && !_kRunLocalTests && !_kRunUITests;

Future<void> main() async {
  await setupIntegrationTests();

  group('Session Mate Integration Tests -', () {
    registerTestKickoff();

    if (_kRunBackendTests || _kRunAllTests) {
      registerBackendSessionTests();
    }
    if (_kRunLocalTests || _kRunAllTests) {
      registerLocalSessionTests();
    }

    if (_kRunUITests || _kRunAllTests) {
      registerWidgetFinderTests();
    }
  });
}
