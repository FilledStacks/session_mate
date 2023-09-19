import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';

class SessionMateOverlay extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRestart;
  const SessionMateOverlay({super.key, required this.child, this.onRestart});

  @override
  Widget build(BuildContext context) {
    return kRecordUserInteractions
        ? InteractionRecorder(child: child)
        : DriverUI(child: child, onRestart: onRestart);
  }
}
