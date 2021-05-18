import 'package:flutter/material.dart';

class DistanceLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 5,
          color: Colors.grey,
        ),
        Container(
          width: 80,
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Icon(
          Icons.circle,
          size: 5,
          color: Colors.grey,
        ),
      ],
    );
  }
}
