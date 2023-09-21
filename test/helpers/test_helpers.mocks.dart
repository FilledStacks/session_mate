// Mocks generated by Mockito 5.4.2 from annotations
// in session_mate/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i11;

import 'package:flutter/material.dart' as _i10;
import 'package:logger/src/logger.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:session_mate/src/services/configuration_service.dart' as _i4;
import 'package:session_mate/src/services/session_recording_service.dart'
    as _i5;
import 'package:session_mate/src/services/session_replay_service.dart' as _i6;
import 'package:session_mate/src/services/session_service.dart' as _i8;
import 'package:session_mate/src/utils/widget_finder.dart' as _i9;
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

/// A class which mocks [ConfigurationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockConfigurationService extends _i1.Mock
    implements _i4.ConfigurationService {
  @override
  bool get dataMaskingEnabled => (super.noSuchMethod(
        Invocation.getter(#dataMaskingEnabled),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  List<String> get excludeKeysOnDataMasking => (super.noSuchMethod(
        Invocation.getter(#excludeKeysOnDataMasking),
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
  void setValues({
    bool? dataMaskingEnabled,
    List<String>? excludeKeysOnDataMasking,
    int? minimumStartupTime,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #setValues,
          [],
          {
            #dataMaskingEnabled: dataMaskingEnabled,
            #excludeKeysOnDataMasking: excludeKeysOnDataMasking,
            #minimumStartupTime: minimumStartupTime,
          },
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SessionRecordingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionRecordingService extends _i1.Mock
    implements _i5.SessionRecordingService {
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
    implements _i6.SessionReplayService {
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
  _i7.Future<List<int>> getSanitizedData(
    List<int>? data, {
    String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSanitizedData,
          [data],
          {#uid: uid},
        ),
        returnValue: _i7.Future<List<int>>.value(<int>[]),
        returnValueForMissingStub: _i7.Future<List<int>>.value(<int>[]),
      ) as _i7.Future<List<int>>);
}

/// A class which mocks [SessionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionService extends _i1.Mock implements _i8.SessionService {
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
  _i2.Session captureSession(
          {_i2.SessionPriority? priority = _i2.SessionPriority.low}) =>
      (super.noSuchMethod(
        Invocation.method(
          #captureSession,
          [],
          {#priority: priority},
        ),
        returnValue: _FakeSession_0(
          this,
          Invocation.method(
            #captureSession,
            [],
            {#priority: priority},
          ),
        ),
        returnValueForMissingStub: _FakeSession_0(
          this,
          Invocation.method(
            #captureSession,
            [],
            {#priority: priority},
          ),
        ),
      ) as _i2.Session);
}

/// A class which mocks [WidgetFinder].
///
/// See the documentation for Mockito's code generation for more information.
class MockWidgetFinder extends _i1.Mock implements _i9.WidgetFinder {
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
  _i10.TextField? getTextFieldAtPosition({
    required _i11.Offset? position,
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
      ) as _i10.TextField?);
}
