import 'package:flutter/material.dart';

class SessionMateBuilder extends StatefulWidget {
  final Widget Function() builder;
  SessionMateBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  State<SessionMateBuilder> createState() => _SessionMateBuilderState();
}

class _SessionMateBuilderState extends State<SessionMateBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
