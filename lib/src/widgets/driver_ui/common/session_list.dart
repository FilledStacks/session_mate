import 'package:flutter/material.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_card.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_list_header.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SessionList extends ViewModelWidget<DriverUIViewModel> {
  const SessionList({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kVerticalPadding,
      ),
      child: Column(
        children: [
          const SessionListHeader(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: kSessionItemTopPadding),
              itemCount: viewModel.sessions.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => viewModel.selectSession(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: kSessionItemTopPadding),
                  child: SessionCard(
                    session: viewModel.sessions[index],
                    isSelected: viewModel.isSessionSelected(index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
