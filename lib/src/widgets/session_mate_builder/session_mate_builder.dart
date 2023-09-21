import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:stacked/stacked.dart';

import 'session_mate_builder_viewmodel.dart';

class SessionMateBuilder extends StackedView<SessionMateBuilderViewModel> {
  final bool dataMaskingEnabled;
  final List<String> excludeKeysOnDataMasking;
  final int minimumStartupTime;
  final Widget child;
  const SessionMateBuilder({
    super.key,
    this.dataMaskingEnabled = true,
    this.excludeKeysOnDataMasking = const [],
    this.minimumStartupTime = 5000,
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
        dataMaskingEnabled: dataMaskingEnabled,
        excludeKeysOnDataMasking: excludeKeysOnDataMasking,
        minimumStartupTime: minimumStartupTime,
      );
}
