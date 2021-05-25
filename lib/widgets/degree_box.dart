import 'package:flutter/material.dart';

class DegreeBox extends StatelessWidget {
  final String degree;
  final num price;
  DegreeBox({@required this.degree, @required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => print("y"),
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.green.shade400),
              color: Colors.green.shade200.withOpacity(.2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(degree), Text('\$$price')],
          ),
        ),
      ),
    );
  }
}
