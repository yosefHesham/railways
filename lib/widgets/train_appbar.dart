import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrainAppBar extends StatefulWidget {
  String title;
  double radius;
  String image;
  Color color;
  TrainAppBar({@required this.title, this.radius, this.image, this.color});

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
        backgroundColor: widget.color == null
            ? const Color(0xff1c0436).withOpacity(0)
            : widget.color,
        expandedHeight: 200,
        stretch: true,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(widget.radius),
              ),
              image: DecorationImage(
                  image: AssetImage(
                    widget.image,
                  ),
                  fit: BoxFit.fill)),
          child: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.all(15),
            stretchModes: [
              StretchMode.blurBackground,
            ],
            title: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: isVisible ? 1 : 0,
              child: Text(
                '${widget.title}',
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
