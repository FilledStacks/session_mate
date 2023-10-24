import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';

class SessionMate extends StatefulWidget {
  final Widget child;
  const SessionMate({super.key, required this.child});

  static void restart(BuildContext context) {
    context.findAncestorStateOfType<_SessionMateState>()?.handle();
  }

  @override
  State<SessionMate> createState() => _SessionMateState();
}

class _SessionMateState extends State<SessionMate> {
  Key key = UniqueKey();

  void handle() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!locator<ConfigurationService>().enabled) return widget.child;

    return KeyedSubtree(key: key, child: widget.child);
  }
}
