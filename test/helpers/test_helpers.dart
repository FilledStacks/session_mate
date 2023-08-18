import 'package:mockito/annotations.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate/src/services/session_service.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SessionRecordingService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SessionService>(onMissingStub: OnMissingStub.returnDefault),
])
MockSessionRecordingService getAndRegisterSessionRecordingService() {
  _removeRegistrationIfExists<SessionRecordingService>();
  final service = MockSessionRecordingService();
  locator.registerSingleton<SessionRecordingService>(service);
  return service;
}

MockSessionService getAndRegisterSessionService() {
  _removeRegistrationIfExists<SessionService>();
  final service = MockSessionService();
  locator.registerSingleton<SessionService>(service);
  return service;
}

void registerServices() {
  getAndRegisterSessionRecordingService();
  getAndRegisterSessionService();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
