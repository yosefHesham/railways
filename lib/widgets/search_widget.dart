import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/departion_query_screen.dart';
import 'package:railways/screens/search_result.dart';
import 'package:railways/widgets/custom_text_field.dart';

class SearchWidget extends StatefulWidget {
  // final textFieldPadding = const EdgeInsets.all(5);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _angle = 0;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationController.addListener(() {
      setState(() {
        _angle = _animationController.value * 45 * pi;
      });
    });
  }

  void switchStations() {
    String temp = departionController.text;
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      departionController.text = destinationController.text;
      destinationController.text = temp;
    });
  }

  var destinationController = TextEditingController(text: "Alexandria");

  var departionController = TextEditingController(text: "Cairo");

  var dateController = TextEditingController(
      text: DateFormat('EEE, d MMM').format(DateTime.now()).toString());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0),
      margin: EdgeInsets.only(top: 15),
      child: Material(
        borderOnForeground: true,
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            children: [
              // departion TextField
              CustomTextField(
                controller: departionController,
                icon: Icons.adjust,
                hintText: "Departion",
                onFieldTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        StationQuery("Departion", saveDepartionStation))),
              ),

              /// Destination TextField
              CustomTextField(
                  controller: destinationController,
                  icon: Icons.location_on_rounded,
                  hintText: "Destination",
                  onFieldTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => StationQuery(
                              "Destination", saveDestinationController)))),

              /// Date TextField
              CustomTextField(
                controller: dateController,
                icon: Icons.calendar_today_sharp,
                hintText: 'Date',
                onFieldTap: () async {
                  final DateTime picked = await chooseDate(context);

                  setState(() {
                    dateController.text =
                        DateFormat('EEE, d MMM').format(picked).toString();
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              searchButton(context),
              // SizedBox(
              //   height: 600,
              // ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * .04,
              right: MediaQuery.of(context).size.width * .15,
              child: switchStationsButton())
        ]),
      ),
    );
  }

  Future<DateTime> chooseDate(BuildContext context) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 6)));
    Provider.of<TrainsProvider>(context, listen: false).chooseDate(date);
    return date;
  }

  Widget switchStationsButton() {
    return InkWell(
      hoverColor: Colors.white.withOpacity(0),
      splashColor: Colors.white.withOpacity(0),
      onTap: () => switchStations(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Public.textFieldFillColor, shape: BoxShape.circle),
        child: Container(
          height: 20,
          width: 20,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Transform.rotate(
              angle: _angle,
              child: Icon(Icons.swap_vert, color: Public.textFieldColor)),
        ),
      ),
    );
  }

  void saveDepartionStation(String station) {
    setState(() {
      departionController.text = station;
    });
  }

  void saveDestinationController(String station) {
    setState(() {
      destinationController.text = station;
    });
  }

  Container searchButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      // ignore: deprecated_member_use
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (destinationController.text == departionController.text) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please choose different stations"),
              ));
              return;
            }
            performSearch(context);
          },
          child: Text(
            'Search',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          )),
    );
  }

  void performSearch(BuildContext context) {
    Provider.of<TrainsProvider>(context, listen: false).fromTo(
        departionController.text,
        destinationController.text,
        dateController.text);
    Navigator.of(context).pushNamed(SearchResultScreen.routeName);
  }
}
