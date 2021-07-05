import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/payment_fields_validator.dart';
import 'package:railways/model/journey.dart';
import 'package:railways/model/stations.dart';
import 'package:railways/model/ticket.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/assets.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/qrcode_screen.dart';
import 'package:railways/widgets/custom_dialog.dart';
import 'package:railways/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  static const routeName = '/booking';

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String name, cardName, cardNumber, expireDate, cvv, phoneNumber;

  void _saveName(String value) {
    name = value;
  }

  void _saveCardName(String value) {
    cardName = value;
  }

  void _saveCardNumber(String value) {
    cardNumber = value;
  }

  void _saveExpireDate(String value) {
    expireDate = value;
  }

  void _saveCVV(String value) {
    cvv = value;
  }

  void _savePhoneNumber(String value) {
    phoneNumber = value;
  }

  var _groupValue = 0;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final trainProv = Provider.of<TrainsProvider>(context, listen: false);
    var fromTime = trainProv.fromStationOfSelectedTrain.departTime.split(':');
    var toTime = trainProv.toStationOfSelectedTrain.arrivalTime.split(':');
    return SafeArea(
        child: Scaffold(
      backgroundColor: Public.textFieldFillColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Consumer<TrainsProvider>(
            builder: (ctx, trainProv, _) => Container(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Public.textFieldColor,
                  ),
                ),
                subtitle: Text(
                  trainProv.bookDate,
                  style: TextStyle(color: Public.textFieldColor),
                ),
                isThreeLine: true,
                title: Text(
                  '${trainProv.fromStation} - ${trainProv.toStation}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review and pay',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                buildTripInfo(trainProv, context, toTime, fromTime),
                SizedBox(
                  height: 15,
                ),
                buildPassengerDetails(context),
                buildPayment(),
                payButton(context, trainProv)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Container payButton(BuildContext context, TrainsProvider trainProv) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      // ignore: deprecated_member_use
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            if (Provider.of<AuthProvider>(context, listen: false).user ==
                null) {
              showDialog(
                  context: context, builder: (ctx) => CustomAlertDialog());
            } else if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              var collection =
                  FirebaseFirestore.instance.collection('journeys');
              var path =
                  await collection.doc(trainProv.selectedTrain.number).get();
              if (!path.exists) {
                await firstTimeBook(trainProv, collection);
              } else {
                Map<String, dynamic> availableSeats = {};
                trainProv.selectedTrain.fareClassess.entries.forEach((element) {
                  availableSeats[element.key] = element.value.noOfSeats;
                });
                String degree = trainProv.selectedClass.keys.first.toString();
                Journey journey = Journey.fromMap(path.data());
                journey.profit += trainProv.selectedClass.entries.first.value;
                journey.passengers++;

                if ((journey.scheduels.first[trainProv.fromStation]
                        as Map<String, dynamic>)
                    .containsKey(trainProv.bookDate)) {
                  for (int i = 0; i < journey.scheduels.length; i++) {
                    String stationName =
                        journey.scheduels[i].keys.first.toString();
                    if (stationName == trainProv.fromStation) {
                      for (int j = i; j < journey.scheduels.length; j++) {
                        String toName =
                            journey.scheduels[j].keys.first.toString();
                        if (toName == trainProv.toStation) {
                          break;
                        } else {
                          journey.scheduels[j][toName][trainProv.bookDate]
                              [degree]--;
                        }
                      }
                    } else {
                      continue;
                    }
                  }
                } else {
                  for (int i = 0; i < journey.scheduels.length; i++) {
                    (journey.scheduels[i][journey.scheduels[i].keys.first]
                            as Map<String, dynamic>)
                        .putIfAbsent(
                            trainProv.bookDate, () => {...availableSeats});
                  }

                  for (int i = 0; i < journey.scheduels.length; i++) {
                    String stationName =
                        journey.scheduels[i].keys.first.toString();
                    if (stationName == trainProv.fromStation) {
                      for (int j = i; j < journey.scheduels.length; j++) {
                        String toName =
                            journey.scheduels[j].keys.first.toString();
                        if (toName == trainProv.toStation) {
                          break;
                        } else {
                          journey.scheduels[j][toName][trainProv.bookDate]
                              [degree]--;
                        }
                      }
                    } else {
                      continue;
                    }
                  }
                }
                collection
                    .doc(trainProv.selectedTrain.number)
                    .set(journey.toMap());
              }
              Ticket ticket = Ticket(
                  date: trainProv.bookDate,
                  trainNo: trainProv.selectedTrain.number,
                  source: trainProv.fromStation,
                  destination: trainProv.toStation,
                  price: trainProv.selectedClass.entries.first.value,
                  name: name,
                  userId: DateTime.now().toIso8601String());
              final docId = FirebaseFirestore.instance
                  .collection('Tickets')
                  .doc()
                    ..set(ticket.toMap(ticket));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => QrCode(ticket, docId.id)));
            }
          },
          child: Text(
            'Pay',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
    );
  }

  Future firstTimeBook(TrainsProvider trainProv,
      CollectionReference<Map<String, dynamic>> collection) async {
    Map<String, dynamic> availableSeats = {};
    trainProv.selectedTrain.fareClassess.entries.forEach((element) {
      availableSeats[element.key] = element.value.noOfSeats;
    });
    List<Map<String, Map<String, Map<String, dynamic>>>> scheduels = [];
    trainProv.selectedTrain.stopStations.forEach((s) {
      Map<String, dynamic> stations = {};
      stations[s.name] = {
        ...{
          trainProv.bookDate: {...availableSeats}
        }
      };
      scheduels.add(stations);
    });

    String degree = trainProv.selectedClass.keys.first.toString();
    for (int i = 0; i < scheduels.length; i++) {
      String stationName = scheduels[i].keys.first.toString();
      if (stationName == trainProv.fromStation) {
        for (int j = i; j < scheduels.length; j++) {
          String toName = scheduels[j].keys.first.toString();
          if (toName == trainProv.toStation) {
            break;
          } else {
            scheduels[j][toName][trainProv.bookDate][degree]--;
          }
        }
      } else {
        continue;
      }
    }
    Journey journey = Journey(
        scheduels: scheduels,
        passengers: 1,
        profit: trainProv.selectedClass.entries.first.value);

    await collection.doc(trainProv.selectedTrain.number).set(journey.toMap());
  }

  Widget buildTripInfo(TrainsProvider trainProv, BuildContext context,
      List<String> toTime, List<String> fromTime) {
    return Column(children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.done_rounded,
                    color: Public.hintTextFieldColor,
                  ),
                  Text(
                    'OUTBOUND',
                    style: TextStyle(color: Public.hintTextFieldColor),
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    trainProv.bookDate,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${trainProv.fromStationOfSelectedTrain.departTime} - ${trainProv.toStationOfSelectedTrain.arrivalTime}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      trainProv.fromStation,
                      style: TextStyle(
                          color: Public.hintTextFieldColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      trainProv.toStation,
                      style: TextStyle(
                          color: Public.hintTextFieldColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Text(
                  'TrainNo: ${trainProv.selectedTrain.number}',
                  style: TextStyle(
                      color: Public.hintTextFieldColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  '${int.parse(toTime[0]) - int.parse(fromTime[0])} h',
                  style: TextStyle(
                      color: Public.hintTextFieldColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                )),
                Spacer(),
              ])
            ],
          ),
        ),
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Tickets: 1',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Price: ${trainProv.selectedClass.entries.first.value}',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      )
    ]);
  }

  Widget buildPassengerDetails(
    BuildContext context,
  ) {
    return Card(
      child: Column(
        children: [
          cardDetails(
            context,
            "Passenger Details",
          ),

          /// name text field
          textFieldWithLabel("Name",
              hint: "eg: ahmed",
              icon: Icons.person,
              onSaved: _saveName,
              validateField: PaymentFieldValidator.validateName),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget textFieldWithLabel(String label,
      {String hint,
      TextEditingController textController,
      IconData icon,
      Function validateField,
      Function onSaved}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Public.hintTextFieldColor),
          ),
          CustomTextField(
            onFieldSubmit: onSaved,
            icon: icon,
            hintText: hint,
            validateField: validateField,
          ),
        ],
      ),
    );
  }

  Widget cardDetails(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget buildPayment() {
    return Card(
      child: Column(
        children: [
          cardDetails(
            context,
            "Select payment method",
          ),
          buildCreditCards(),
          _groupValue == 0 ? creditCardTFF() : Divider(),
          buildVodCash(),
          _groupValue == 1
              ? textFieldWithLabel("Your number",
                  onSaved: _savePhoneNumber,
                  validateField: PaymentFieldValidator.validatePhoneNumber)
              : Container()
        ],
      ),
    );
  }

  Column creditCardTFF() {
    return Column(
      children: [
        textFieldWithLabel("Name on card",
            onSaved: _saveCardName,
            validateField: PaymentFieldValidator.validateName),
        textFieldWithLabel("Card number",
            onSaved: _saveCardNumber,
            validateField: PaymentFieldValidator.validateCardNum),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: textFieldWithLabel("Expiration date",
                    onSaved: _saveExpireDate,
                    validateField: PaymentFieldValidator.validateExpireDate)),
            Expanded(
                child: textFieldWithLabel("CVV",
                    onSaved: _saveCVV,
                    validateField: PaymentFieldValidator.validateCVV)),
          ],
        ),
      ],
    );
  }

  Widget buildCreditCards() {
    return Row(
      children: [
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: 0,
          groupValue: _groupValue,
          onChanged: _handleRadioValue,
        ),
        FaIcon(
          FontAwesomeIcons.ccVisa,
          color: Public.accent,
        ),
        SizedBox(
          width: 5,
        ),
        FaIcon(
          FontAwesomeIcons.ccMastercard,
          color: Public.accent,
        )
      ],
    );
  }

  void _handleRadioValue(int value) {
    setState(() {
      _groupValue = value;
    });
  }

  Widget buildVodCash() {
    return Row(
      children: [
        Radio(
          value: 1,
          groupValue: _groupValue,
          onChanged: _handleRadioValue,
        ),
        CircleAvatar(
          backgroundImage: AssetImage(
            vodafone,
          ),
          radius: 25,
        )
      ],
    );
  }
}
