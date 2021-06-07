import 'package:flutter/material.dart';
import 'package:railways/public/colors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StationQuery extends StatefulWidget {
  static const routeName = '/stationQuery';

  String hintText;
  final saveStation;

  StationQuery(this.hintText, this.saveStation);
  @override
  _StationQueryState createState() => _StationQueryState();
}

class _StationQueryState extends State<StationQuery> {
  var controller = TextEditingController();
  var fieldNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.bluetooth_disabled),
              onPressed: () => Navigator.of(context).pop(),
              color: Public.hintTextFieldColor,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(widget.hintText,
                style: TextStyle(
                    color: Public.hintTextFieldColor,
                    fontWeight: FontWeight.bold))),
        body: Align(
            alignment: Alignment.topCenter,
            child: TypeAheadField<String>(
                noItemsFoundBuilder: (context) => new ListTile(
                      title: new Text('Your input did not match any station !'),
                    ),
                suggestionsCallback: (input) {
                  return _suggestions.where((element) =>
                      element.toLowerCase().contains(input.toLowerCase()));
                },
                onSuggestionSelected: (value) {
                  print("a7aaaa $value");

                  setState(() {
                    controller.text = value;
                    FocusScope.of(context).requestFocus(fieldNode);
                  });
                },
                // itemFilter: (suggestion, input) =>
                //     suggestion.toLowerCase().contains(input.toLowerCase()),
                itemBuilder: (context, suggestion) => new Padding(
                    child: new ListTile(
                      title: new Text(suggestion),
                    ),
                    padding: EdgeInsets.all(8.0)),
                // itemSorter: (a, b) => 1,
                // suggestions: _suggestions,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller,
                  onSubmitted: (v) {
                    widget.saveStation(v);
                    Navigator.of(context).pop();
                  },
                  style: TextStyle(color: Public.hintTextFieldColor),
                  focusNode: fieldNode,
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: Public.hintTextFieldColor),
                      prefixIcon: Icon(
                        Icons.ac_unit,
                        color: Public.textFieldColor,
                        size: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Public.textFieldColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Public.textFieldFillColor)),
                      filled: true,
                      fillColor: Public.textFieldFillColor,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Public.textFieldFillColor),
                          borderRadius: BorderRadius.circular(8))),
                ))));
  }
}

List<String> _suggestions = [
  'Alexandria',
  'Sidi Gaber',
  'Kafr Aldawaar',
  'Abu Homs',
  'Damanhur',
  'Etay Elbarrowd',
  'Eltawfiqiuh',
  'Kafr Elzyat',
  'Tanta',
  'Barkih alsabe',
  'Quesna',
  'Banha',
  'Tookh',
  'Qaha',
  'Qalyoub',
  'Shubra',
  'Cairo'
];
