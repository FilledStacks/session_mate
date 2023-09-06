import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SessionStatus extends ViewModelWidget<DriverUIViewModel> {
  const SessionStatus({super.key});

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: PhysicalShape(
            color: Colors.greenAccent,
            shadowColor: Colors.blueGrey,
            elevation: 18,
            clipper: ShapeBorderClipper(shape: CircleBorder()),
            child: const SizedBox(height: 16, width: 16),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Connected',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ],
    );
  }
}
