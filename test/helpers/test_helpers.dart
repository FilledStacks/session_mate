import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/widget_finder.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<ConfigurationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SessionRecordingService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SessionReplayService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SessionService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WidgetFinder>(onMissingStub: OnMissingStub.returnDefault),
])
MockConfigurationService getAndRegisterConfigurationService({
  bool dataMaskingEnabled = true,
  List<String> keysToExcludeOnDataMasking = const [],
  int minimumStartupTime = 5000,
  int listeningPort = 3000,
}) {
  _removeRegistrationIfExists<ConfigurationService>();
  final service = MockConfigurationService();

  when(service.dataMaskingEnabled).thenReturn(dataMaskingEnabled);
  when(service.keysToExcludeOnDataMasking)
      .thenReturn(keysToExcludeOnDataMasking);
  when(service.minimumStartupTime).thenReturn(minimumStartupTime);
  when(service.listeningPort).thenReturn(listeningPort);

  when(service.allKeysToExclude).thenReturn([
    ...commonKeysToExcludeOnDataMasking,
    ...keysToExcludeOnDataMasking,
  ]);

  locator.registerSingleton<ConfigurationService>(service);
  return service;
}

MockSessionRecordingService getAndRegisterSessionRecordingService() {
  _removeRegistrationIfExists<SessionRecordingService>();
  final service = MockSessionRecordingService();
  locator.registerSingleton<SessionRecordingService>(service);
  return service;
}

MockWidgetFinder getAndRegisterWidgetFinder() {
  _removeRegistrationIfExists<WidgetFinder>();
  final service = MockWidgetFinder();
  locator.registerSingleton<WidgetFinder>(service);
  return service;
}

MockSessionReplayService getAndRegisterSessionReplayService() {
  _removeRegistrationIfExists<SessionReplayService>();
  final service = MockSessionReplayService();
  locator.registerSingleton<SessionReplayService>(service);
  return service;
}

MockSessionService getAndRegisterSessionService() {
  _removeRegistrationIfExists<SessionService>();
  final service = MockSessionService();
  locator.registerSingleton<SessionService>(service);
  return service;
}

void registerServices() {
  getAndRegisterConfigurationService();
  getAndRegisterSessionRecordingService();
  getAndRegisterSessionReplayService();
  getAndRegisterSessionService();
  getAndRegisterWidgetFinder();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
