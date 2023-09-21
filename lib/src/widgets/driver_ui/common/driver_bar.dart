import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:svg_icon/svg_icon.dart';

class DriverBar extends ViewModelWidget<DriverUIViewModel> {
  const DriverBar({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Container(
      alignment: viewModel.showDriverBar ? Alignment.centerLeft : null,
      decoration: BoxDecoration(
        color: Color(0xFF4D3CC2),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width:
          viewModel.showDriverBar ? MediaQuery.of(context).size.width * .9 : 60,
      child: viewModel.showDriverBar
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: viewModel.toggleDriverBar,
                  child: SvgIcon(
                    'packages/session_mate/assets/driver_bar_icons/action-close.svg',
                    color: Color(0xFFFFFFFF),
                    width: 35,
                    height: 35,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: viewModel.toggleDebugMode,
                  child: SvgIcon(
                    'packages/session_mate/assets/driver_bar_icons/action-${viewModel.showDebugInformation ? 'hide' : 'show'}-coordinates.svg',
                    color: Color(0xFFFFFFFF),
                    width: 35,
                    height: 35,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: viewModel.toggleSessionList,
                  child: SvgIcon(
                    'packages/session_mate/assets/driver_bar_icons/action-${viewModel.showSessionList ? 'hide' : 'show'}-ui.svg',
                    color: Color(0xFFFFFFFF),
                    width: 35,
                    height: 35,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: viewModel.startSession,
                  child: SvgIcon(
                    'packages/session_mate/assets/driver_bar_icons/action-replay-session.svg',
                    color: Color(0xFFFFFFFF),
                    width: 35,
                    height: 35,
                  ),
                ),
              ],
            )
          : GestureDetector(
              onTap: viewModel.toggleDriverBar,
              child: SvgIcon(
                'packages/session_mate/assets/driver_bar_icons/action-open.svg',
                color: Color(0xFFFFFFFF),
                width: 35,
                height: 35,
              ),
            ),
    );
  }
}
