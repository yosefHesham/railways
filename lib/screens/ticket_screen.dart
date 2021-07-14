import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/distance_line.dart';

class TicketWithQrCode extends StatelessWidget {
  const TicketWithQrCode(
      {Key key,
      @required this.source,
      @required this.date,
      @required this.destination,
      @required this.price,
      @required this.ticketId,
      @required this.trainNo,
      @required this.name})
      : super(key: key);

  final String source;
  final String destination;
  final num price;
  final String date;
  final String trainNo;
  final String ticketId;
  final name;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: [
          Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  date,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      source,
                      style: TextStyle(
                          color: Public.hintTextFieldColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w200),
                    ),
                    DistanceLine(),
                    Text(
                      destination,
                      style: TextStyle(
                          color: Public.hintTextFieldColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Spacer(),
                      Expanded(
                          flex: 2,
                          child: Text(
                            'TrainNo: $trainNo',
                            style: TextStyle(
                                color: Public.hintTextFieldColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w200),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Passenger Name: $name',
                            style: TextStyle(
                                color: Public.hintTextFieldColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w200),
                          )),
                      Spacer()
                    ]),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Price: $price',
                  style: TextStyle(
                      color: Public.hintTextFieldColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                )
              ])),
          Spacer(),
          Center(
            child: QrImage(
              data: ticketId,
              size: 300,
            ),
          ),
          Spacer()
        ]));
  }
}
