import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/departion_query_screen.dart';
import 'package:railways/widgets/custom_text_field.dart';

class SearchWidget extends StatefulWidget {
  // final textFieldPadding = const EdgeInsets.all(5);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var destinationController = TextEditingController(text: "Alex");

  var departionController = TextEditingController(text: "Cairo");

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
              CustomTextField(
                controller: departionController,
                icon: Icons.adjust,
                hintText: "Departion",
                onFieldTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        StationQuery("Departion", saveDepartionStation))),
              ),
              CustomTextField(
                  controller: destinationController,
                  icon: Icons.location_on_rounded,
                  hintText: "Destination",
                  onFieldTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => StationQuery(
                              "Destination", saveDestinationController)))),
              CustomTextField(
                  controller: destinationController,
                  icon: Icons.calendar_today_sharp,
                  hintText:
                      DateFormat.yMEd().format(DateTime.now()).toString()),
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

  Container searchButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      // ignore: deprecated_member_use
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).accentColor,
          onPressed: () => print("search"),
          child: Text(
            'Search',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          )),
    );
  }
}

Widget switchStationsButton() {
  return InkWell(
    hoverColor: Colors.white.withOpacity(0),
    splashColor: Colors.white.withOpacity(0),
    onTap: () => print("switch"),
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Public.textFieldFillColor, shape: BoxShape.circle),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(Icons.swap_vert, color: Public.textFieldColor),
      ),
    ),
  );
}
