import 'package:flutter/material.dart';

class GuestRestarter extends StatefulWidget {
  final Widget child;
  const GuestRestarter({super.key, required this.child});

  static void run(BuildContext context) {
    context.findAncestorStateOfType<_GuestRestarterState>()?.run();
  }

  @override
  State<GuestRestarter> createState() => _GuestRestarterState();
}

class _GuestRestarterState extends State<GuestRestarter> {
  Key key = UniqueKey();

  void run() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}
