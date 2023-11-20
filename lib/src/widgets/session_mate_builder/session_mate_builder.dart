import 'package:flutter/material.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder.dart';
import 'package:stacked/stacked.dart';

import 'session_mate_builder_viewmodel.dart';

class SessionMateBuilder extends StackedView<SessionMateBuilderViewModel> {
  final String? apiKey;
  final bool dataMaskingEnabled;
  final List<String> keysToExcludeOnDataMasking;
  final int minimumStartupTime;
  final bool logRawNetworkEvents;
  final bool logNetworkEvents;
  final bool logUIEvents;
  final bool logNavigationEvents;
  final bool logCliEvents;
  final bool logSweetCoreEvents;
  final bool logGuestAppEvents;
  final bool verboseLogs;
  final Widget child;
  final bool inputMaskingEnabled;

  const SessionMateBuilder({
    super.key,
    this.apiKey,
    this.inputMaskingEnabled = true,
    this.dataMaskingEnabled = true,
    this.keysToExcludeOnDataMasking = const [],
    this.minimumStartupTime = 5000,
    this.logRawNetworkEvents = false,
    this.logNetworkEvents = false,
    this.logUIEvents = false,
    this.logNavigationEvents = false,
    this.logCliEvents = false,
    this.logSweetCoreEvents = false,
    this.logGuestAppEvents = false,
    this.verboseLogs = false,
    required this.child,
  });

  @override
  Widget builder(
    BuildContext context,
    SessionMateBuilderViewModel viewModel,
    // ignore: avoid_renaming_method_parameters
    Widget? _,
  ) {
    return kRecordUserInteractions
        ? InteractionRecorder(child: child)
        : kReplaySession
            ? DriverUI(child: child)
            : child;
  }

  @override
  void onViewModelReady(SessionMateBuilderViewModel viewModel) {
    viewModel.init();
  }

  @override
  SessionMateBuilderViewModel viewModelBuilder(BuildContext context) =>
      SessionMateBuilderViewModel(
        apiKey: apiKey,
        dataMaskingEnabled: dataMaskingEnabled,
        keysToExcludeOnDataMasking: keysToExcludeOnDataMasking,
        minimumStartupTime: minimumStartupTime,
        logRawNetworkEvents: logRawNetworkEvents,
        logNetworkEvents: logNetworkEvents,
        logUIEvents: logUIEvents,
        logNavigationEvents: logNavigationEvents,
        logCliEvents: logCliEvents,
        logSweetCoreEvents: logSweetCoreEvents,
        logGuestAppEvents: logGuestAppEvents,
        verboseLogs: verboseLogs,
        inputMaskingEnabled: inputMaskingEnabled,
      );
}
