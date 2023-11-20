import 'package:flutter/material.dart';
import 'package:session_mate/src/extensions/ui_extensions.dart';
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(session.priority.icon, width: 20),
                    SizedBox(width: 5),
                    Text(
                      session.priority.nameRecased,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Text(
                  '${session.events.whereType<UIEvent>().length} steps',
                  style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF4B4957),
                      fontSize: 10),
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
                  style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF4B4957),
                      fontSize: 12),
                ),
                Text(
                  session.timeAgo,
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                ),
              ],
            ),
          ),
          if (isSelected)
            ...session.events.whereType<UIEvent>().map((UIEvent e) {
              return Card(
                color: Color(0xFF232228),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: e.type.toColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          e.type.name,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (e is ScrollEvent) ...[
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'from: (${e.position.x.toInt()}, ${e.position.y.toInt()}) by: (${e.scrollDelta?.x.toInt()}, ${e.scrollDelta?.y.toInt()})',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                      if (e is DragEvent) ...[
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'from: (${e.position.x.toInt()}, ${e.position.y.toInt()}) to: (${e.scrollEnd.x.toInt()}, ${e.scrollEnd.y.toInt()})',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                      if (e is TapEvent) ...[
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'at: (${e.position.x.toInt()}, ${e.position.y.toInt()})',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                      if (e is InputEvent) ...[
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${e.inputData} at: (${e.position.x.toInt()}, ${e.position.y.toInt()}) ',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                      Spacer(),
                      Text(
                        e.view,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()
        ],
      ),
    );
  }
}
