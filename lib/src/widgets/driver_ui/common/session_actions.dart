import 'package:flutter/material.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_replay_button.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_status.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SessionActions extends ViewModelWidget<DriverUIViewModel> {
  const SessionActions({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SessionStatus(),
          const SizedBox(height: 12),
          const SessionReplayButton(),
        ],
      ),
    );
  }
}
