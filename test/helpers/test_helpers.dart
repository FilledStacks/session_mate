import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/notification_extractor.dart';
import 'package:session_mate/src/utils/reactive_scrollable.dart';
import 'package:session_mate/src/utils/scroll_applicator.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';

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
  MockSpec<DriverCommunicationService>(
      onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SessionMateRouteTracker>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TimeUtils>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScrollApplicator>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NotificationExtractor>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ReactiveScrollable>(onMissingStub: OnMissingStub.returnDefault),
])
MockReactiveScrollable getAndRegisterReactiveScrollable() {
  _removeRegistrationIfExists<ReactiveScrollable>();
  final service = MockReactiveScrollable();
  locator.registerSingleton<ReactiveScrollable>(service);
  return service;
}

MockNotificationExtractor getAndRegisterNotificationExtractor() {
  _removeRegistrationIfExists<NotificationExtractor>();
  final service = MockNotificationExtractor();
  locator.registerSingleton<NotificationExtractor>(service);
  return service;
}

MockScrollApplicator getAndRegisterScrollApplicator() {
  _removeRegistrationIfExists<ScrollApplicator>();
  final service = MockScrollApplicator();
  locator.registerSingleton<ScrollApplicator>(service);
  return service;
}

MockTimeUtils getAndRegisterTimeUtils() {
  _removeRegistrationIfExists<TimeUtils>();
  final service = MockTimeUtils();
  locator.registerSingleton<TimeUtils>(service);
  return service;
}

MockSessionMateRouteTracker getAndRegisterSessionMateRouteTracker() {
  _removeRegistrationIfExists<SessionMateRouteTracker>();
  final service = MockSessionMateRouteTracker();
  locator.registerSingleton<SessionMateRouteTracker>(service);
  return service;
}

MockDriverCommunicationService getAndRegisterDriverCommunicationService({
  bool readyToReplay = false,
  bool replayActive = true,
}) {
  _removeRegistrationIfExists<DriverCommunicationService>();
  final service = MockDriverCommunicationService();

  when(service.readyToReplay).thenReturn(readyToReplay);
  when(service.replayActive).thenReturn(replayActive);

  locator.registerSingleton<DriverCommunicationService>(service);
  return service;
}

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
  getAndRegisterDriverCommunicationService();
  getAndRegisterSessionMateRouteTracker();
  getAndRegisterTimeUtils();
  getAndRegisterScrollApplicator();
  getAndRegisterReactiveScrollable();
  getAndRegisterNotificationExtractor();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

T registerServiceInsteadOfMockedOne<T extends Object>(T instance) {
  _removeRegistrationIfExists<T>();
  locator.registerSingleton<T>(instance);
  return instance;
}
