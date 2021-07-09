import 'package:flutter/material.dart';

class RatingValue extends StatelessWidget {
  const RatingValue({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: MediaQuery.of(context).size.width * .3,
      child: Stack(
        children: [
          Container(color: Colors.grey[200]),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .2,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
