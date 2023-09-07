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
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.asset("assets/icons/fire.png"),
                    Text(
                      session.priority.icon,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    ),
                    SizedBox(width: 6),
                    Text(
                      session.priority.nameRecased,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    ),
                  ],
                ),
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
          ...session.events.map((SessionEvent e) {
            return Text(e.toString());
          }).toList()
        ],
      ),
    );
  }
}
