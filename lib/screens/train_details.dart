import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/review_screen.dart';
import 'package:railways/screens/running_status_screen.dart';
import 'package:railways/screens/train_route.dart';
import 'package:railways/widgets/booking_details.dart';
import 'package:railways/widgets/rating_value.dart';

// ignore: must_be_immutable
class TrainDetailScreen extends StatefulWidget {
  Train train;
  TrainDetailScreen(this.train);

  @override
  _TrainDetailScreenState createState() => _TrainDetailScreenState();
}

class _TrainDetailScreenState extends State<TrainDetailScreen> {
  bool bookingOptionsVisble = false;
  String _dropDownValue = "1A";
  @override
  Widget build(BuildContext context) {
    print("${widget.train.fareClassess.keys.toList()}");
    bool runAllDays = !widget.train.weekDayRuns.containsValue(false);
    List<String> runningDays = [];
    widget.train.weekDayRuns.entries.forEach((element) {
      if (element.value) {
        runningDays.add(element.key);
      }
    });
    final from = Provider.of<TrainsProvider>(context, listen: true)
        .fromStationOfSelectedTrain;
    final to = Provider.of<TrainsProvider>(context, listen: true)
        .toStationOfSelectedTrain;
    print("trainNo ${widget.train.number}");
    DateTime chosenDate = Provider.of<TrainsProvider>(
      context,
    ).chosenDate;
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
                  widget.train.number,
                  style: TextStyle(
                      color: Public.textFieldFillColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "Runs on: ",
                      style: TextStyle(
                          color: Public.textFieldColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      runAllDays
                          ? "All Days"
                          : runningDays
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                      style: TextStyle(
                          color: Public.textFieldColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Column(
                            /// of the first two lines
                            children: [
                              stationRow(from.name, from.departTime),
                              Divider(
                                color: Colors.grey,
                              ),
                              stationRow(to.name, to.arrivalTime)
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[200],
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: 80,
                              child: DropdownButton<String>(
                                  hint: Text("Class"),
                                  value: _dropDownValue,
                                  onChanged: (v) {
                                    setState(() {
                                      _dropDownValue = v;
                                    });
                                    Provider.of<TrainsProvider>(context,
                                            listen: false)
                                        .selectClass({_dropDownValue: 100});
                                  },
                                  items: widget.train.fareClassess.keys
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList()),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              bookingOptionsVisble = !bookingOptionsVisble;
                            });
                            // Provider.of<TrainsProvider>(context, listen: false)
                            //     .showBookingOptions(widget.train.number);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'SEAT AVAILABILITY',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Public.textFieldFillColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            color: Color(0xff2043B0),
                          ),
                        ),
                        bookingOptionsVisble
                            ? BookingDetails(widget.train.weekDayRuns,
                                degree: _dropDownValue)
                            : Container(),
                      ],
                    ),
                  ),

                  /// of the first box
                ),
              ),

              ///first container child
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => RunningStatusScreen(
                              Provider.of<TrainsProvider>(context,
                                      listen: false)
                                  .selectedTrain,
                              chosenDate))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/run_status_icon.png',
                              ),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Running',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: VerticalDivider(
                        width: 100,
                        color: Colors.grey[400],
                        thickness: 1.2,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => TrainRoute(widget.train))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image(
                              image: AssetImage(
                                'assets/images/route_icon.png',
                              ),
                              color: Color(0xff2043B0),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          //SizedBox(height: 15,),
                          Text(
                            'Route',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              _buildReviewsAndRating(),

              ///second container child
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * .8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Tap to rate this train: ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          height: 1.2,
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rate,
                          color: Color(0xff2043B0),
                        ),
                        onRatingUpdate: (rating) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ReviewScreen(rating)));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              ///for rating
            ],
          ),
        ),

        ///the parent column
      ),
    );
  }

  Row stationRow(String name, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 18,
              height: 1.2,
            ),
          ),
        ),
        Text(
          time.substring(0, 5),
          style: TextStyle(
            fontSize: 18,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsAndRating() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ratings",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 22)),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width * .9,
                child: Divider(
                  color: Colors.black,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text('4.2',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 30)),
                  Text("out of 5",
                      style: TextStyle(
                          color: Public.textFieldColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15))
                ]),
                Column(children: [
                  Text(
                    'Cleanliness',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Discipline',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Comfort",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  )
                ]),
                Column(
                  children: [1, 2, 3]
                      .map((e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: RatingValue()))
                      .toList(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
