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
            widthFactor: .5,
            heightFactor: 1,
            child: Container(
              alignment: Alignment.centerRight,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
