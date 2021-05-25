import 'package:flutter/material.dart';

class TrainBadge extends StatelessWidget {
  final title;
  TrainBadge(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.shade900)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 10,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.blue.shade900, fontSize: 10),
          )
        ],
      ),
    );
  }
}
