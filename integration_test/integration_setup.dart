import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:session_mate/session_mate.dart';

import '../test/helpers/test_helpers.dart';

const _apiKey = bool.hasEnvironment('SESSION_MATE_API_KEY')
    ? String.fromEnvironment('SESSION_MATE_API_KEY')
    : null;

Future<void> setupIntegrationTests() async {
  // Integration test specific setup
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.onlyPumps;

  await setupSessionMate();

  getAndRegisterNativeInformationService();
  getAndRegisterConfigurationService(
    apiKey: _apiKey ?? 'fb2e384c-97aa-446a-ac22-c15612be1cb0',
  );
}

void registerTestKickoff() {
  testWidgets('Prepare test by settling', (WidgetTester tester) async {
    await _settleTest(tester);
  });
}

Future<void> _settleTest(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
        body: Center(
      child: Text('Running Integration Tests'),
    )),
  ));
  await tester.pumpAndSettle();
}
