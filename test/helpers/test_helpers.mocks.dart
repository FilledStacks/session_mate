// Mocks generated by Mockito 5.4.2 from annotations
// in session_mate/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:io' as _i11;
import 'dart:ui' as _i6;

import 'package:device_info_plus/device_info_plus.dart' as _i5;
import 'package:flutter/material.dart' as _i14;
import 'package:logger/src/logger.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:package_info_plus/package_info_plus.dart' as _i4;
import 'package:session_mate/src/services/configuration_service.dart' as _i7;
import 'package:session_mate/src/services/data_masking_service.dart' as _i23;
import 'package:session_mate/src/services/driver_communication_service.dart'
    as _i17;
import 'package:session_mate/src/services/http_service.dart' as _i16;
import 'package:session_mate/src/services/native_inforamation_service.dart'
    as _i15;
import 'package:session_mate/src/services/session_recording_service.dart'
    as _i8;
import 'package:session_mate/src/services/session_replay_service.dart' as _i9;
import 'package:session_mate/src/services/session_service.dart' as _i12;
import 'package:session_mate/src/utils/notification_extractor.dart' as _i21;
import 'package:session_mate/src/utils/reactive_scrollable.dart' as _i22;
import 'package:session_mate/src/utils/scroll_applicator.dart' as _i20;
import 'package:session_mate/src/utils/time_utils.dart' as _i19;
import 'package:session_mate/src/utils/widget_finder.dart' as _i13;
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart'
    as _i18;
import 'package:session_mate_core/session_mate_core.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSession_0 extends _i1.SmartFake implements _i2.Session {
  _FakeSession_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLogger_1 extends _i1.SmartFake implements _i3.Logger {
  _FakeLogger_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePackageInfo_2 extends _i1.SmartFake implements _i4.PackageInfo {
  _FakePackageInfo_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeviceInfoPlugin_3 extends _i1.SmartFake
    implements _i5.DeviceInfoPlugin {
  _FakeDeviceInfoPlugin_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAndroidDeviceInfo_4 extends _i1.SmartFake
    implements _i5.AndroidDeviceInfo {
  _FakeAndroidDeviceInfo_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIosDeviceInfo_5 extends _i1.SmartFake implements _i5.IosDeviceInfo {
  _FakeIosDeviceInfo_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUIEvent_6 extends _i1.SmartFake implements _i2.UIEvent {
  _FakeUIEvent_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeScrollableDescription_7 extends _i1.SmartFake
    implements _i2.ScrollableDescription {
  _FakeScrollableDescription_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOffset_8 extends _i1.SmartFake implements _i6.Offset {
  _FakeOffset_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ConfigurationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockConfigurationService extends _i1.Mock
    implements _i7.ConfigurationService {
  @override
  bool get dataMaskingEnabled => (super.noSuchMethod(
        Invocation.getter(#dataMaskingEnabled),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  List<String> get keysToExcludeOnDataMasking => (super.noSuchMethod(
        Invocation.getter(#keysToExcludeOnDataMasking),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);
  @override
  List<String> get allKeysToExclude => (super.noSuchMethod(
        Invocation.getter(#allKeysToExclude),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);
  @override
  int get minimumStartupTime => (super.noSuchMethod(
        Invocation.getter(#minimumStartupTime),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  int get listeningPort => (super.noSuchMethod(
        Invocation.getter(#listeningPort),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  String get apiKey => (super.noSuchMethod(
        Invocation.getter(#apiKey),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  bool get hasApiKey => (super.noSuchMethod(
        Invocation.getter(#hasApiKey),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void setValues({
    bool? dataMaskingEnabled,
    List<String>? keysToExcludeOnDataMasking,
    int? minimumStartupTime,
    int? listeningPort,
    String? apiKey,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #setValues,
          [],
          {
            #dataMaskingEnabled: dataMaskingEnabled,
            #keysToExcludeOnDataMasking: keysToExcludeOnDataMasking,
            #minimumStartupTime: minimumStartupTime,
            #listeningPort: listeningPort,
            #apiKey: apiKey,
          },
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SessionRecordingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionRecordingService extends _i1.Mock
    implements _i8.SessionRecordingService {
  @override
  void handleEvent(_i2.NetworkEvent? event) => super.noSuchMethod(
        Invocation.method(
          #handleEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SessionReplayService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionReplayService extends _i1.Mock
    implements _i9.SessionReplayService {
  @override
  void handleEvent(_i2.NetworkEvent? event) => super.noSuchMethod(
        Invocation.method(
          #handleEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void populateCache(List<_i2.NetworkEvent>? events) => super.noSuchMethod(
        Invocation.method(
          #populateCache,
          [events],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i10.Future<void> handleMockRequest(_i11.HttpRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #handleMockRequest,
          [request],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
  @override
  _i10.Future<List<int>> getSanitizedData(
    List<int>? data, {
    String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSanitizedData,
          [data],
          {#uid: uid},
        ),
        returnValue: _i10.Future<List<int>>.value(<int>[]),
        returnValueForMissingStub: _i10.Future<List<int>>.value(<int>[]),
      ) as _i10.Future<List<int>>);
}

/// A class which mocks [SessionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionService extends _i1.Mock implements _i12.SessionService {
  @override
  List<_i2.NetworkEvent> get networkEvents => (super.noSuchMethod(
        Invocation.getter(#networkEvents),
        returnValue: <_i2.NetworkEvent>[],
        returnValueForMissingStub: <_i2.NetworkEvent>[],
      ) as List<_i2.NetworkEvent>);
  @override
  List<_i2.SessionEvent> get sessionEvents => (super.noSuchMethod(
        Invocation.getter(#sessionEvents),
        returnValue: <_i2.SessionEvent>[],
        returnValueForMissingStub: <_i2.SessionEvent>[],
      ) as List<_i2.SessionEvent>);
  @override
  List<_i2.UIEvent> get uiEvents => (super.noSuchMethod(
        Invocation.getter(#uiEvents),
        returnValue: <_i2.UIEvent>[],
        returnValueForMissingStub: <_i2.UIEvent>[],
      ) as List<_i2.UIEvent>);
  @override
  List<String> get views => (super.noSuchMethod(
        Invocation.getter(#views),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);
  @override
  int get listenersCount => (super.noSuchMethod(
        Invocation.getter(#listenersCount),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  void addEvent(_i2.SessionEvent? event) => super.noSuchMethod(
        Invocation.method(
          #addEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addAllEvents(List<_i2.SessionEvent>? events) => super.noSuchMethod(
        Invocation.method(
          #addAllEvents,
          [events],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addView(String? view) => super.noSuchMethod(
        Invocation.method(
          #addView,
          [view],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setActiveSession(_i2.Session? selectedSession) => super.noSuchMethod(
        Invocation.method(
          #setActiveSession,
          [selectedSession],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.Session captureSession({
    Object? exception,
    StackTrace? stackTrace,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #captureSession,
          [],
          {
            #exception: exception,
            #stackTrace: stackTrace,
          },
        ),
        returnValue: _FakeSession_0(
          this,
          Invocation.method(
            #captureSession,
            [],
            {
              #exception: exception,
              #stackTrace: stackTrace,
            },
          ),
        ),
        returnValueForMissingStub: _FakeSession_0(
          this,
          Invocation.method(
            #captureSession,
            [],
            {
              #exception: exception,
              #stackTrace: stackTrace,
            },
          ),
        ),
      ) as _i2.Session);
  @override
  void listenToReactiveValues(List<dynamic>? reactiveValues) =>
      super.noSuchMethod(
        Invocation.method(
          #listenToReactiveValues,
          [reactiveValues],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(void Function()? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(void Function()? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [WidgetFinder].
///
/// See the documentation for Mockito's code generation for more information.
class MockWidgetFinder extends _i1.Mock implements _i13.WidgetFinder {
  @override
  _i3.Logger get log => (super.noSuchMethod(
        Invocation.getter(#log),
        returnValue: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
        returnValueForMissingStub: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
      ) as _i3.Logger);
  @override
  Iterable<_i2.ScrollableDescription> getAllScrollablesOnScreen() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllScrollablesOnScreen,
          [],
        ),
        returnValue: <_i2.ScrollableDescription>[],
        returnValueForMissingStub: <_i2.ScrollableDescription>[],
      ) as Iterable<_i2.ScrollableDescription>);
  @override
  _i14.TextField? getTextFieldAtPosition({
    required _i6.Offset? position,
    bool? verbose = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTextFieldAtPosition,
          [],
          {
            #position: position,
            #verbose: verbose,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i14.TextField?);
}

/// A class which mocks [NativeInformationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNativeInformationService extends _i1.Mock
    implements _i15.NativeInformationService {
  @override
  _i4.PackageInfo get packageInfo => (super.noSuchMethod(
        Invocation.getter(#packageInfo),
        returnValue: _FakePackageInfo_2(
          this,
          Invocation.getter(#packageInfo),
        ),
        returnValueForMissingStub: _FakePackageInfo_2(
          this,
          Invocation.getter(#packageInfo),
        ),
      ) as _i4.PackageInfo);
  @override
  set packageInfo(_i4.PackageInfo? _packageInfo) => super.noSuchMethod(
        Invocation.setter(
          #packageInfo,
          _packageInfo,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.DeviceInfoPlugin get deviceInfo => (super.noSuchMethod(
        Invocation.getter(#deviceInfo),
        returnValue: _FakeDeviceInfoPlugin_3(
          this,
          Invocation.getter(#deviceInfo),
        ),
        returnValueForMissingStub: _FakeDeviceInfoPlugin_3(
          this,
          Invocation.getter(#deviceInfo),
        ),
      ) as _i5.DeviceInfoPlugin);
  @override
  set deviceInfo(_i5.DeviceInfoPlugin? _deviceInfo) => super.noSuchMethod(
        Invocation.setter(
          #deviceInfo,
          _deviceInfo,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.AndroidDeviceInfo get androidDeviceInfo => (super.noSuchMethod(
        Invocation.getter(#androidDeviceInfo),
        returnValue: _FakeAndroidDeviceInfo_4(
          this,
          Invocation.getter(#androidDeviceInfo),
        ),
        returnValueForMissingStub: _FakeAndroidDeviceInfo_4(
          this,
          Invocation.getter(#androidDeviceInfo),
        ),
      ) as _i5.AndroidDeviceInfo);
  @override
  set androidDeviceInfo(_i5.AndroidDeviceInfo? _androidDeviceInfo) =>
      super.noSuchMethod(
        Invocation.setter(
          #androidDeviceInfo,
          _androidDeviceInfo,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.IosDeviceInfo get iosDeviceInfo => (super.noSuchMethod(
        Invocation.getter(#iosDeviceInfo),
        returnValue: _FakeIosDeviceInfo_5(
          this,
          Invocation.getter(#iosDeviceInfo),
        ),
        returnValueForMissingStub: _FakeIosDeviceInfo_5(
          this,
          Invocation.getter(#iosDeviceInfo),
        ),
      ) as _i5.IosDeviceInfo);
  @override
  set iosDeviceInfo(_i5.IosDeviceInfo? _iosDeviceInfo) => super.noSuchMethod(
        Invocation.setter(
          #iosDeviceInfo,
          _iosDeviceInfo,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get appVersion => (super.noSuchMethod(
        Invocation.getter(#appVersion),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get appId => (super.noSuchMethod(
        Invocation.getter(#appId),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get osVersion => (super.noSuchMethod(
        Invocation.getter(#osVersion),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get platform => (super.noSuchMethod(
        Invocation.getter(#platform),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get uniqueIdentifier => (super.noSuchMethod(
        Invocation.getter(#uniqueIdentifier),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i10.Future<void> intialise() => (super.noSuchMethod(
        Invocation.method(
          #intialise,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
}

/// A class which mocks [HttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpService extends _i1.Mock implements _i16.HttpService {
  @override
  _i10.Future<List<_i2.Session>> getSessions() => (super.noSuchMethod(
        Invocation.method(
          #getSessions,
          [],
        ),
        returnValue: _i10.Future<List<_i2.Session>>.value(<_i2.Session>[]),
        returnValueForMissingStub:
            _i10.Future<List<_i2.Session>>.value(<_i2.Session>[]),
      ) as _i10.Future<List<_i2.Session>>);
  @override
  _i10.Future<bool> saveSession({required _i2.Session? session}) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSession,
          [],
          {#session: session},
        ),
        returnValue: _i10.Future<bool>.value(false),
        returnValueForMissingStub: _i10.Future<bool>.value(false),
      ) as _i10.Future<bool>);
  @override
  _i10.Future<bool> deleteSessions() => (super.noSuchMethod(
        Invocation.method(
          #deleteSessions,
          [],
        ),
        returnValue: _i10.Future<bool>.value(false),
        returnValueForMissingStub: _i10.Future<bool>.value(false),
      ) as _i10.Future<bool>);
}

/// A class which mocks [DriverCommunicationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDriverCommunicationService extends _i1.Mock
    implements _i17.DriverCommunicationService {
  @override
  bool get readyToReplay => (super.noSuchMethod(
        Invocation.getter(#readyToReplay),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  bool get wasReplayExecuted => (super.noSuchMethod(
        Invocation.getter(#wasReplayExecuted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  int get listenersCount => (super.noSuchMethod(
        Invocation.getter(#listenersCount),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  void setOnReplayCompletedCallback(_i6.VoidCallback? callback) =>
      super.noSuchMethod(
        Invocation.method(
          #setOnReplayCompletedCallback,
          [callback],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i10.Future<String> waitForInteractions() => (super.noSuchMethod(
        Invocation.method(
          #waitForInteractions,
          [],
        ),
        returnValue: _i10.Future<String>.value(''),
        returnValueForMissingStub: _i10.Future<String>.value(''),
      ) as _i10.Future<String>);
  @override
  void sendInteractions(List<_i2.UIEvent>? interactions) => super.noSuchMethod(
        Invocation.method(
          #sendInteractions,
          [interactions],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void listenToReactiveValues(List<dynamic>? reactiveValues) =>
      super.noSuchMethod(
        Invocation.method(
          #listenToReactiveValues,
          [reactiveValues],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(void Function()? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(void Function()? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SessionMateRouteTracker].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionMateRouteTracker extends _i1.Mock
    implements _i18.SessionMateRouteTracker {
  @override
  bool get testMode => (super.noSuchMethod(
        Invocation.getter(#testMode),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set testMode(bool? _testMode) => super.noSuchMethod(
        Invocation.setter(
          #testMode,
          _testMode,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Map<String, int> get indexedRouteStateMap => (super.noSuchMethod(
        Invocation.getter(#indexedRouteStateMap),
        returnValue: <String, int>{},
        returnValueForMissingStub: <String, int>{},
      ) as Map<String, int>);
  @override
  set indexedRouteStateMap(Map<String, int>? _indexedRouteStateMap) =>
      super.noSuchMethod(
        Invocation.setter(
          #indexedRouteStateMap,
          _indexedRouteStateMap,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get previosRoute => (super.noSuchMethod(
        Invocation.getter(#previosRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  set previosRoute(String? _previosRoute) => super.noSuchMethod(
        Invocation.setter(
          #previosRoute,
          _previosRoute,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get currentRoute => (super.noSuchMethod(
        Invocation.getter(#currentRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get formatedCurrentRoute => (super.noSuchMethod(
        Invocation.getter(#formatedCurrentRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void setCurrentRoute(String? route) => super.noSuchMethod(
        Invocation.method(
          #setCurrentRoute,
          [route],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setRoute(String? route) => super.noSuchMethod(
        Invocation.method(
          #setRoute,
          [route],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void changeRouteIndex(
    String? viewName,
    int? index,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #changeRouteIndex,
          [
            viewName,
            index,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveRouteIndex(
    String? viewName,
    int? index,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #saveRouteIndex,
          [
            viewName,
            index,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void loadRouteIndexIfExist(String? viewName) => super.noSuchMethod(
        Invocation.method(
          #loadRouteIndexIfExist,
          [viewName],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TimeUtils].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimeUtils extends _i1.Mock implements _i19.TimeUtils {
  @override
  int get timestamp => (super.noSuchMethod(
        Invocation.getter(#timestamp),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}

/// A class which mocks [ScrollApplicator].
///
/// See the documentation for Mockito's code generation for more information.
class MockScrollApplicator extends _i1.Mock implements _i20.ScrollApplicator {
  @override
  _i3.Logger get log => (super.noSuchMethod(
        Invocation.getter(#log),
        returnValue: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
        returnValueForMissingStub: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
      ) as _i3.Logger);
  @override
  _i2.UIEvent applyScrollableToEvent(
    Iterable<_i2.ScrollableDescription>? scrollables,
    _i2.UIEvent? event,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #applyScrollableToEvent,
          [
            scrollables,
            event,
          ],
        ),
        returnValue: _FakeUIEvent_6(
          this,
          Invocation.method(
            #applyScrollableToEvent,
            [
              scrollables,
              event,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeUIEvent_6(
          this,
          Invocation.method(
            #applyScrollableToEvent,
            [
              scrollables,
              event,
            ],
          ),
        ),
      ) as _i2.UIEvent);
  @override
  _i2.UIEvent storeDescriptionInScrollableExternalities(
    Iterable<_i2.ScrollableDescription>? scrollablesBelowInteraction,
    _i2.UIEvent? interaction,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeDescriptionInScrollableExternalities,
          [
            scrollablesBelowInteraction,
            interaction,
          ],
        ),
        returnValue: _FakeUIEvent_6(
          this,
          Invocation.method(
            #storeDescriptionInScrollableExternalities,
            [
              scrollablesBelowInteraction,
              interaction,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeUIEvent_6(
          this,
          Invocation.method(
            #storeDescriptionInScrollableExternalities,
            [
              scrollablesBelowInteraction,
              interaction,
            ],
          ),
        ),
      ) as _i2.UIEvent);
  @override
  _i2.UIEvent storeDescriptionInExternalities(
    Iterable<_i2.ScrollableDescription>? scrollablesBelowInteraction,
    _i2.UIEvent? event,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeDescriptionInExternalities,
          [
            scrollablesBelowInteraction,
            event,
          ],
        ),
        returnValue: _FakeUIEvent_6(
          this,
          Invocation.method(
            #storeDescriptionInExternalities,
            [
              scrollablesBelowInteraction,
              event,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeUIEvent_6(
          this,
          Invocation.method(
            #storeDescriptionInExternalities,
            [
              scrollablesBelowInteraction,
              event,
            ],
          ),
        ),
      ) as _i2.UIEvent);
  @override
  _i2.ScrollableDescription findBiggestScrollable(
          Iterable<_i2.ScrollableDescription>? scrollablesBelowInteraction) =>
      (super.noSuchMethod(
        Invocation.method(
          #findBiggestScrollable,
          [scrollablesBelowInteraction],
        ),
        returnValue: _FakeScrollableDescription_7(
          this,
          Invocation.method(
            #findBiggestScrollable,
            [scrollablesBelowInteraction],
          ),
        ),
        returnValueForMissingStub: _FakeScrollableDescription_7(
          this,
          Invocation.method(
            #findBiggestScrollable,
            [scrollablesBelowInteraction],
          ),
        ),
      ) as _i2.ScrollableDescription);
}

/// A class which mocks [NotificationExtractor].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationExtractor extends _i1.Mock
    implements _i21.NotificationExtractor {
  @override
  set scrollDirection(_i2.ScrollDirection? _scrollDirection) =>
      super.noSuchMethod(
        Invocation.setter(
          #scrollDirection,
          _scrollDirection,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Offset get globalPosition => (super.noSuchMethod(
        Invocation.getter(#globalPosition),
        returnValue: _FakeOffset_8(
          this,
          Invocation.getter(#globalPosition),
        ),
        returnValueForMissingStub: _FakeOffset_8(
          this,
          Invocation.getter(#globalPosition),
        ),
      ) as _i6.Offset);
  @override
  set globalPosition(_i6.Offset? _globalPosition) => super.noSuchMethod(
        Invocation.setter(
          #globalPosition,
          _globalPosition,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Offset get localPosition => (super.noSuchMethod(
        Invocation.getter(#localPosition),
        returnValue: _FakeOffset_8(
          this,
          Invocation.getter(#localPosition),
        ),
        returnValueForMissingStub: _FakeOffset_8(
          this,
          Invocation.getter(#localPosition),
        ),
      ) as _i6.Offset);
  @override
  set localPosition(_i6.Offset? _localPosition) => super.noSuchMethod(
        Invocation.setter(
          #localPosition,
          _localPosition,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set lastScrollEvent(_i2.ScrollableDescription? _lastScrollEvent) =>
      super.noSuchMethod(
        Invocation.setter(
          #lastScrollEvent,
          _lastScrollEvent,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool onlyScrollUpdateNotification(_i14.Notification? notification) =>
      (super.noSuchMethod(
        Invocation.method(
          #onlyScrollUpdateNotification,
          [notification],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  List<_i2.UIEvent> scrollEvents(
    _i2.ScrollableDescription? scrollableDescription,
    List<_i2.UIEvent>? uiEvents,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #scrollEvents,
          [
            scrollableDescription,
            uiEvents,
          ],
        ),
        returnValue: <_i2.UIEvent>[],
        returnValueForMissingStub: <_i2.UIEvent>[],
      ) as List<_i2.UIEvent>);
  @override
  _i2.ScrollableDescription notificationToScrollableDescription(
          _i14.Notification? notification) =>
      (super.noSuchMethod(
        Invocation.method(
          #notificationToScrollableDescription,
          [notification],
        ),
        returnValue: _FakeScrollableDescription_7(
          this,
          Invocation.method(
            #notificationToScrollableDescription,
            [notification],
          ),
        ),
        returnValueForMissingStub: _FakeScrollableDescription_7(
          this,
          Invocation.method(
            #notificationToScrollableDescription,
            [notification],
          ),
        ),
      ) as _i2.ScrollableDescription);
  @override
  _i2.UIEvent syncInteractionWithScrollable(_i2.UIEvent? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #syncInteractionWithScrollable,
          [event],
        ),
        returnValue: _FakeUIEvent_6(
          this,
          Invocation.method(
            #syncInteractionWithScrollable,
            [event],
          ),
        ),
        returnValueForMissingStub: _FakeUIEvent_6(
          this,
          Invocation.method(
            #syncInteractionWithScrollable,
            [event],
          ),
        ),
      ) as _i2.UIEvent);
}

/// A class which mocks [ReactiveScrollable].
///
/// See the documentation for Mockito's code generation for more information.
class MockReactiveScrollable extends _i1.Mock
    implements _i22.ReactiveScrollable {
  @override
  _i3.Logger get log => (super.noSuchMethod(
        Invocation.getter(#log),
        returnValue: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
        returnValueForMissingStub: _FakeLogger_1(
          this,
          Invocation.getter(#log),
        ),
      ) as _i3.Logger);
  @override
  _i2.ScrollableDescription get currentScrollableDescription =>
      (super.noSuchMethod(
        Invocation.getter(#currentScrollableDescription),
        returnValue: _FakeScrollableDescription_7(
          this,
          Invocation.getter(#currentScrollableDescription),
        ),
        returnValueForMissingStub: _FakeScrollableDescription_7(
          this,
          Invocation.getter(#currentScrollableDescription),
        ),
      ) as _i2.ScrollableDescription);
  @override
  set currentScrollableDescription(
          _i2.ScrollableDescription? _currentScrollableDescription) =>
      super.noSuchMethod(
        Invocation.setter(
          #currentScrollableDescription,
          _currentScrollableDescription,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Iterable<_i2.UIEvent> filterAffectedInteractionsByScrollable(
          List<_i2.UIEvent>? uiEvents) =>
      (super.noSuchMethod(
        Invocation.method(
          #filterAffectedInteractionsByScrollable,
          [uiEvents],
        ),
        returnValue: <_i2.UIEvent>[],
        returnValueForMissingStub: <_i2.UIEvent>[],
      ) as Iterable<_i2.UIEvent>);
  @override
  _i6.Offset calculateOffsetDeviation(
    _i2.ScrollableDescription? scrollableDescription,
    _i2.UIEvent? interaction,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #calculateOffsetDeviation,
          [
            scrollableDescription,
            interaction,
          ],
        ),
        returnValue: _FakeOffset_8(
          this,
          Invocation.method(
            #calculateOffsetDeviation,
            [
              scrollableDescription,
              interaction,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeOffset_8(
          this,
          Invocation.method(
            #calculateOffsetDeviation,
            [
              scrollableDescription,
              interaction,
            ],
          ),
        ),
      ) as _i6.Offset);
  @override
  Iterable<_i2.UIEvent> moveInteractionsWithScrollable(
          Iterable<_i2.UIEvent>? affectedEvents) =>
      (super.noSuchMethod(
        Invocation.method(
          #moveInteractionsWithScrollable,
          [affectedEvents],
        ),
        returnValue: <_i2.UIEvent>[],
        returnValueForMissingStub: <_i2.UIEvent>[],
      ) as Iterable<_i2.UIEvent>);
}

/// A class which mocks [DataMaskingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataMaskingService extends _i1.Mock
    implements _i23.DataMaskingService {
  @override
  String stringSubstitution(String? item) => (super.noSuchMethod(
        Invocation.method(
          #stringSubstitution,
          [item],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  num numSubstitution(num? item) => (super.noSuchMethod(
        Invocation.method(
          #numSubstitution,
          [item],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as num);
}
