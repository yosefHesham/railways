import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';

class DegreeBox extends StatefulWidget {
  final String degree;
  final num price;
  final String trainNum;

  DegreeBox(
      {@required this.degree, @required this.price, @required this.trainNum});

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

          setState(() {
            selected = true;
          });
          Future.delayed(Duration(seconds: 5)).then((_) => {
                setState(() {
                  selected = false;
                })
              });
        },
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                  color: selected
                      ? Public.textFieldFillColor
                      : Colors.green.shade400),
              color: Colors.green.shade200.withOpacity(.2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(widget.degree), Text('\$${widget.price}')],
          ),
        ),
      ),
    );
  }
}
