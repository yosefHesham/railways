import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railways/public/colors.dart';

class SearchWidget extends StatelessWidget {
  // final textFieldPadding = const EdgeInsets.all(5);
  final textFieldMargin = const EdgeInsets.only(top: 8);
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
              buildTextField(Icons.adjust, "Departion"),
              buildTextField(Icons.location_on_rounded, "Destination"),
              buildTextField(Icons.calendar_today_sharp,
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

  Widget buildTextField(IconData icon, String hintText) {
    print(hintText);
    return Builder(builder: (ctx) {
      return Container(
        // padding: textFieldPadding,
        margin: textFieldMargin,
        height: 40,
        width: MediaQuery.of(ctx).size.width * .95,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: hintText,
              hintStyle: TextStyle(color: hintTextFieldColor),
              prefixIcon: Icon(
                icon,
                color: textFieldColor,
                size: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: textFieldColor),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: textFieldFillColor)),
              filled: true,
              fillColor: textFieldFillColor,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: textFieldFillColor),
                  borderRadius: BorderRadius.circular(8))),
        ),
      );
    });
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
      decoration:
          BoxDecoration(color: textFieldFillColor, shape: BoxShape.circle),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(Icons.swap_vert, color: textFieldColor),
      ),
    ),
  );
}
