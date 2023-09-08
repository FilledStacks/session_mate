import 'package:flutter/material.dart';

class BookIdentifier extends StatelessWidget {
  final String id;
  final bool small;
  const BookIdentifier({super.key, required this.id, this.small = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(small ? 4 : 8),
      width: small ? 30 : 80,
      child: Text(
        id,
        style: TextStyle(
          fontSize: small ? 12 : 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
