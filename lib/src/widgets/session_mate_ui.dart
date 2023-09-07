import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';

class SessionMate extends StatelessWidget {
  final Widget child;
  const SessionMate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return false ? InteractionRecorder(child: child) : DriverUI(child: child);
  }
}
