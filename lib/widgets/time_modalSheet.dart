import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/filters.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';

class TimeModalSheet extends StatefulWidget {
  @override
  _TimeModalSheetState createState() => _TimeModalSheetState();
}

class _TimeModalSheetState extends State<TimeModalSheet> {
  void onChangedDepart(bool v, String key) {
    departAt[key] = v;
    if (v) {
      selectedValues.add(key);

      maxOptions--;
    } else if (!v) {
      selectedValues.remove(key);
      maxOptions++;
    }

    setState(() {});
  }

  int maxOptions = 2;
  List<String> selectedValues = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .3,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text(
                      "Departure",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Choose 2 options",
                      style: TextStyle(color: Public.accent),
                    )
                  ]),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Row(
            children: [
              checkBoxTile(
                lable: "Early Morning",
                value: departAt['Early Morning'],
                onChanged: onChangedDepart,
              ),
              checkBoxTile(
                lable: "Afternoon",
                value: departAt['Afternoon'],
                onChanged: onChangedDepart,
              ),
            ],
          ),
          Row(
            children: [
              checkBoxTile(
                lable: "Morning",
                value: departAt['Morning'],
                onChanged: onChangedDepart,
              ),
              checkBoxTile(
                lable: "Night",
                value: departAt['Night'],
                onChanged: onChangedDepart,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      departAt.updateAll((key, value) => false);
                      maxOptions = 2;
                      selectedValues.clear();
                    });
                    Provider.of<TrainsProvider>(context, listen: false)
                        .filterTrains();
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.blueAccent),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<TrainsProvider>(context, listen: false)
                        .filterTrains();
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ]));
  }

  Widget checkBoxTile({String lable, bool value, Function onChanged}) {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Checkbox(
                value: value,
                onChanged: maxOptions == 0 && !selectedValues.contains(lable)
                    ? null
                    : (v) {
                        onChanged(v, lable);
                      }),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          Expanded(
            child: Column(
              children: [
                Text(
                  lable,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text(
                  mapTimeToHours[lable],
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
