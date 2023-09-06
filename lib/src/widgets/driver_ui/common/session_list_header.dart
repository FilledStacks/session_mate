import 'package:flutter/material.dart';

class SessionListHeader extends StatelessWidget {
  const SessionListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Color(0xFF232228),
        title: Center(
          child: Text(
            'Faulty Sessions',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
