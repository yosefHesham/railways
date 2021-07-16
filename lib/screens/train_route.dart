import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrainRoute extends StatelessWidget {
  final Train train;
  TrainRoute(this.train);

  @override
  Widget build(BuildContext context) {
    final from =
        Provider.of<TrainsProvider>(context, listen: false).fromStation;
    final to = Provider.of<TrainsProvider>(context, listen: false).toStation;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
                color: Theme.of(context).primaryColor,
                child: ListTile(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Public.textFieldColor,
                    ),
                  ),
                  title: Text(
                    train.number,
                    style: TextStyle(
                        color: Public.textFieldFillColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                )),
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
              child: Container(
            child: Stack(children: [
              Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * .8,
                  child: Column(
                    children: train.stopStations
                        .map((station) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: TimelineTile(
                                  isFirst: station.name == from ? true : false,
                                  isLast: station.name == to ? true : false,
                                  beforeLineStyle: LineStyle(
                                      color: Theme.of(context).primaryColor),
                                  afterLineStyle: LineStyle(
                                      color: Theme.of(context).primaryColor),
                                  indicatorStyle: IndicatorStyle(
                                      color: Theme.of(context).primaryColor),
                                  endChild: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 35,
                                      ),
                                      buildText(station.name, 2),
                                      buildText(
                                          station.arrivalTime.substring(0, 5),
                                          1),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      buildText(
                                          station.departTime.substring(0, 5),
                                          1),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      buildText(station.stopTime.toString(), 1),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .025,
                child: Material(
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.do_disturb_alt_outlined,
                          size: 25,
                          color: Colors.grey.withOpacity(0),
                        ),
                      ),
                      buildText("Station", 2),
                      buildText("Arr", 1),
                      buildText("Dep", 1),
                      buildText("Stop", 1)
                    ],
                  ),
                ),
              ),
            ]),
          ))),
    );
  }
}

Widget buildText(String title, int flexValue) {
  return Expanded(
    flex: flexValue,
    child: Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
  );
}
