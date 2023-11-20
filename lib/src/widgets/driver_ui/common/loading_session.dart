import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoadingSessionOrEmptyMessage extends ViewModelWidget<DriverUIViewModel> {
  const LoadingSessionOrEmptyMessage({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 2000),
      child: viewModel.isBusy
          ? Center(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFFFFFFFF)),
                  SizedBox(height: 20),
                  Text(
                    'loading session...',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          : viewModel.hasCustomMessage
              ? Container(
                  color: Color(0xFF232228),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      viewModel.customMessage!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
