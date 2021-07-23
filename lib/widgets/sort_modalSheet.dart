import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/filters.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';

class SortModalSheet extends StatefulWidget {
  @override
  _SortModalSheetState createState() => _SortModalSheetState();
}

class _SortModalSheetState extends State<SortModalSheet> {
  void onChangeSort(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  final sortByDep = "Departure";
  final sortByArr = "Arrival";

  String _groupValue = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .25,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
              Row(
                children: [
                  radioButtonTile(lable: sortByDep, onChanged: onChangeSort),
                  radioButtonTile(lable: sortByArr, onChanged: onChangeSort)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _groupValue = "";
                        });
                        // Provider.of<TrainsProvider>(context, listen: false)
                        //     .filterTrains();
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<TrainsProvider>(context, listen: false)
                            .sortTrains(_groupValue);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ]));
  }

  Widget radioButtonTile({String lable, Function onChanged}) {
    return Container(
      width: 200,
      child: RadioListTile(
        title: Text(
          lable,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        value: lable,
        onChanged: onChangeSort,
        groupValue: _groupValue,
      ),
    );
  }
}
