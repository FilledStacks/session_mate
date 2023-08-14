import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';

class SessionMate extends StatelessWidget {
  final Widget child;
  const SessionMate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showInteractionRecorder = kReleaseMode || kProfileMode;

    return showInteractionRecorder
        ? InteractionRecorder(child: child)
        : DriverUI(child: child);
  }
}
