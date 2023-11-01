import 'package:flutter/material.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserIdleTime extends ViewModelWidget<DriverUIViewModel> {
  const UserIdleTime({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF232228),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              'User idle',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
              ),
            ),
            Text(
              '${viewModel.formattedIdleTime} s',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
