import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:stacked/stacked.dart';

import 'session_mate_builder_viewmodel.dart';

class SessionMateBuilder extends StackedView<SessionMateBuilderViewModel> {
  final String? apiKey;
  final bool dataMaskingEnabled;
  final List<String> keysToExcludeOnDataMasking;
  final int minimumStartupTime;
  final bool logNetworkData;
  final Widget child;
  const SessionMateBuilder({
    super.key,
    this.apiKey,
    this.dataMaskingEnabled = true,
    this.keysToExcludeOnDataMasking = const [],
    this.minimumStartupTime = 5000,
    this.logNetworkData = false,
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
        : DriverUI(child: child);
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
        logNetworkData: logNetworkData,
      );
}
