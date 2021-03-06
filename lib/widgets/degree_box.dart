import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';

// ignore: must_be_immutable
class DegreeBox extends StatefulWidget {
  final String degree;
  final num price;
  final String trainNum;
  Color borderColor;

  int index;
  final Function changeIndex;

  DegreeBox(
      {@required this.degree,
      @required this.price,
      @required this.trainNum,
      this.borderColor,
      this.changeIndex,
      this.index});

  @override
  _DegreeBoxState createState() => _DegreeBoxState();
}

class _DegreeBoxState extends State<DegreeBox> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Provider.of<TrainsProvider>(context, listen: false)
              .showBookingOptions(widget.trainNum);
          Provider.of<TrainsProvider>(context, listen: false)
              .selectClass({widget.degree: widget.price});
          widget.changeIndex(widget.index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .25,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: widget.borderColor),
              color: widget.borderColor.withOpacity(.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.degree} ${widget.price}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                "EGP",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
