import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/drag_recorder.dart';
import 'package:session_mate/src/utils/notification_extractor.dart';
import 'package:session_mate/src/utils/reactive_scrollable.dart';
import 'package:session_mate/src/utils/scroll_applicator.dart';
import 'package:session_mate/src/utils/text_input_recorder.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';

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
  MockSpec<DataMaskingService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TextInputRecorder>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DragRecorder>(onMissingStub: OnMissingStub.returnDefault),

  // Models
  MockSpec<ScrollUpdateNotification>(
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
MockDragRecorder getAndRegisterDragRecorder({
  bool isRecording = false,
}) {
  _removeRegistrationIfExists<DragRecorder>();
  final service = MockDragRecorder();

  when(service.isRecording).thenReturn(isRecording);
  locator.registerSingleton<DragRecorder>(service);
  return service;
}

MockTextInputRecorder getAndRegisterTextInputRecorder() {
  _removeRegistrationIfExists<TextInputRecorder>();
  final service = MockTextInputRecorder();
  locator.registerSingleton<TextInputRecorder>(service);
  return service;
}

MockDataMaskingService getAndRegisterDataMaskingService({
  Map<String, dynamic> maskedResponseMap = const {},
}) {
  _removeRegistrationIfExists<DataMaskingService>();
  final service = MockDataMaskingService();

  when(service.handle(any)).thenReturn(maskedResponseMap);
  locator.registerSingleton<DataMaskingService>(service);
  return service;
}

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

  when(service.applyScrollableToEvent(any, any))
      .thenReturn(TapEvent(position: EventPosition(x: 1, y: 0)));

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
  when(service.headersKeysToExclude)
      .thenReturn(headersKeysToExcludeOnDataMasking);
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

MockWidgetFinder getAndRegisterWidgetFinder({
  List<(TextEditingController, Rect)> allTextFieldsOnScreen = const [],
}) {
  _removeRegistrationIfExists<WidgetFinder>();
  final service = MockWidgetFinder();

  when(service.getAllTextFieldsOnScreen()).thenReturn(allTextFieldsOnScreen);

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

DataMaskingService getAndRegisterRealMaskingService() {
  _removeRegistrationIfExists<DataMaskingService>();
  final service = DataMaskingService();
  locator.registerSingleton<DataMaskingService>(service);
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
  getAndRegisterDataMaskingService();
  getAndRegisterTextInputRecorder();
  getAndRegisterDragRecorder();
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
