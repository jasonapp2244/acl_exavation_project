import 'package:flutter/material.dart';

class CustomStatusTile extends StatelessWidget {
  final String title;
  final bool isOnline; // true = online, false = offline

  const CustomStatusTile({
    Key? key,
    required this.title,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Status circle

        // Title text
        Text(
          title.isNotEmpty ? title : 'On Site',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isOnline ? Colors.green : Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
