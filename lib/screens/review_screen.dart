import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/review_widget.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatefulWidget {
  double generalRate;
  ReviewScreen(this.generalRate);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

Map<num, dynamic> rateEvaluation = {
  1: "Poor",
  2: "Okay",
  3: "Good",
  4: "Great",
  5: "Excellent"
};

class _ReviewScreenState extends State<ReviewScreen> {
  num cleanliness, comfort, descipline;
  void _saveClealliness(num rate) {
    setState(() {
      cleanliness = rate;
    });
  }

  void _saveComfort(num rate) {
    setState(() {
      comfort = rate;
    });
  }

  void _saveDescipline(num rate) {
    setState(() {
      descipline = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Review"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: widget.generalRate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 35,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star_rate,
                  color: Color(0xff2043B0),
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    widget.generalRate = rating;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                rateEvaluation[widget.generalRate],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              dividerWithMargin(),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                ReviewWidget(
                  ratingType: "Clealliness: ",
                  saveRating: _saveClealliness,
                ),
                ReviewWidget(
                  ratingType: "Discipline:   ",
                  saveRating: _saveDescipline,
                ),
                ReviewWidget(
                  ratingType: "Comfort:      ",
                  saveRating: _saveComfort,
                )
              ]),
              dividerWithMargin(),
              GestureDetector(
                onTap: null,
                child: Card(
                  color: Color(0xff2043B0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .07,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'SUBMIT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Public.textFieldFillColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container dividerWithMargin() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        thickness: 1,
        color: Colors.black45,
      ),
    );
  }
}

List<String> reviewTypes = ["Cleanliness:", "Discipline:", "Comfort:"];
