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
          viewModel.isBusy
              ? const _SessionsLoadingIndicator()
              : viewModel.showEmptySessionsMessage
                  ? const _NoSessionsCaptured()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        padding:
                            const EdgeInsets.only(top: kSessionItemTopPadding),
                        itemCount: viewModel.sessions.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => viewModel.selectSession(index),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: kSessionItemTopPadding),
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

class _SessionsLoadingIndicator extends StatelessWidget {
  const _SessionsLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFFFFFFFF)),
          SizedBox(height: 20),
          Text(
            'Fetching sessions ...',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}

class _NoSessionsCaptured extends StatelessWidget {
  const _NoSessionsCaptured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          'No sessions captured yet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
