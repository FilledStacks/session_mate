import 'package:flutter_test/flutter_test.dart';

import 'integration.backend.sessions.dart';
import 'integration.local.sessions.dart';
import 'integration.ui.widget_finder.dart';
import 'integration_setup.dart';

const _kRunBackendTests = bool.fromEnvironment('BACKEND_ONLY');
const _kRunLocalTests = bool.fromEnvironment('LOCAL_ONLY');
const _kRunUITests = bool.fromEnvironment('UI_ONLY');

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
