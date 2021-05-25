import 'package:flutter/material.dart';
import 'package:railways/public/assets.dart';

class TrainAppBar extends StatelessWidget {
  const TrainAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: const Color(0xff1c0436).withOpacity(0),
        expandedHeight: 200,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
              image: DecorationImage(
                  image: AssetImage(
                    splash,
                  ),
                  fit: BoxFit.fill)),
          child: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.all(15),
            title: Text(
              'Where to?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Walsheim"),
            ),
          ),
        ));
  }
}
