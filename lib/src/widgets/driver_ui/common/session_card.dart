import 'package:flutter/material.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionCard extends StatelessWidget {
  final Session session;
  final bool isSelected;
  const SessionCard({
    super.key,
    required this.session,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(session.priority.icon, width: 20),
                SizedBox(width: 5),
                Text(
                  '${session.events.length} steps',
                  style: TextStyle(color: Color(0xFF4B4957), fontSize: 10),
                ),
              ],
            ),
            tileColor: isSelected
                ? Color.fromARGB(255, 93, 90, 109)
                : Color(0xFF232228),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Last occurance',
                  style: TextStyle(color: Color(0xFF4B4957), fontSize: 12),
                ),
                Text(
                  session.timeAgo,
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                ),
              ],
            ),
          ),
          if (isSelected)
            ...session.events.map((SessionEvent e) {
              return Card(
                color: Color(0xFF232228),
                child: Text(
                  e.describe(),
                  style: TextStyle(fontSize: 9),
                ),
              );
            }).toList()
        ],
      ),
    );
  }
}
