import 'package:flutter/material.dart';
import 'package:railways/public/assets.dart';

class TrainAppBar extends StatefulWidget {
  const TrainAppBar({
    Key key,
  }) : super(key: key);

  @override
  _TrainAppBarState createState() => _TrainAppBarState();
}

class _TrainAppBarState extends State<TrainAppBar> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => setState(() {
          isVisible = true;
        }));
  }

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
                    appBarImg,
                  ),
                  fit: BoxFit.fill)),
          child: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.all(15),
            title: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: isVisible ? 1 : 0,
              child: Text(
                'Where to?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Walsheim"),
              ),
            ),
          ),
        ));
  }
}
