import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
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
  MockSpec<NativeInformationService>(
      onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HttpService>(onMissingStub: OnMissingStub.returnDefault),
])
MockNativeInformationService getAndRegisterNativeInformationService({
  String appVersion = '1.0.0',
  String appId = 'com.filledstacks.bookshelf',
  String osVersion = '10.2',
  String platform = 'android',
  String uniqueIdentifier = '1',
}) {
  _removeRegistrationIfExists<NativeInformationService>();
  final service = MockNativeInformationService();

  when(service.appVersion).thenReturn(appVersion);
  when(service.appId).thenReturn(appId);
  when(service.osVersion).thenReturn(osVersion);
  when(service.platform).thenReturn(platform);
  when(service.uniqueIdentifier).thenReturn(uniqueIdentifier);

  locator.registerSingleton<NativeInformationService>(service);
  return service;
}

MockHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<HttpService>();
  final service = MockHttpService();
  locator.registerSingleton<HttpService>(service);
  return service;
}

MockConfigurationService getAndRegisterConfigurationService({
  bool dataMaskingEnabled = true,
  List<String> keysToExcludeOnDataMasking = const [],
  int minimumStartupTime = 5000,
  int listeningPort = 3000,
  String apiKey = 'NO_API_KEY',
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
  when(service.apiKey).thenReturn(apiKey);

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
  getAndRegisterHttpService();
  getAndRegisterNativeInformationService();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
