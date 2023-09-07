import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DriverBar extends ViewModelWidget<DriverUIViewModel> {
  const DriverBar({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Column(
      children: [
        Expanded(child: const SizedBox.shrink()),
        Container(
          alignment: viewModel.showDriverBar ? Alignment.centerLeft : null,
          color: viewModel.hasSelectedSession
              ? Color(0xFF4D3CC2)
              : Colors.grey[400],
          padding: const EdgeInsets.all(6),
          child: viewModel.showDriverBar
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: viewModel.toggleDriverBar,
                      child: Icon(
                        Icons.highlight_off_rounded,
                        color: Color(0xFFFFFFFF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Image.asset(
                    //   '$assets_path/icons/thumbs-down.png',
                    //   width: 20,
                    // ),
                    GestureDetector(
                      onTap: viewModel.toggleEventVerbose,
                      child: Icon(
                        Icons.event,
                        color: Color(0xFFFFFFFF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: viewModel.toggleSessionList,
                      child: Icon(
                        Icons.list,
                        color: Color(0xFFFFFFFF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: viewModel.startSession,
                      child: Icon(
                        Icons.play_circle,
                        color: Color(0xFFFFFFFF),
                        size: 20,
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: viewModel.toggleDriverBar,
                  child: Icon(
                    Icons.highlight_off_rounded,
                    color: Color(0xFFFFFFFF),
                    size: 20,
                  ),
                ),
        ),
      ],
    );
  }
}
