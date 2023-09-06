import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SessionReplayButton extends ViewModelWidget<DriverUIViewModel> {
  const SessionReplayButton({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          minWidth: 80,
          onPressed: viewModel.startSession,
          color: viewModel.hasSelectedSession
              ? Color(0xFF4D3CC2)
              : Colors.grey[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
          child: Text(
            'Replay',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
