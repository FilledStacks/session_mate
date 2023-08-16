import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/package_constants.dart';

class SessionMate extends StatelessWidget {
  final Widget child;
  const SessionMate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kRecordUserInteractions
        ? InteractionRecorder(child: child)
        : DriverUI(child: child);
  }
}
