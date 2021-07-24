import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:railways/model/ticket.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> _allTickets = [];
  Future<void> getTickets() async {
    User user = FirebaseAuth.instance.currentUser;

    var snapShot = await FirebaseFirestore.instance
        .collection("profiles")
        .doc(user.uid)
        .collection("reservations")
        .get();
    List<Ticket> tempList =
        snapShot.docs.map((ticket) => Ticket.fromMap(ticket.data())).toList();
    _allTickets = tempList;
    notifyListeners();
  }

  List<Ticket> get upcomingTickets {
    if (_allTickets.isNotEmpty) {
      return _allTickets.where((ticket) {
        return DateTime.parse(formatString(ticket.journeyDate))
            .isAfter(DateTime.now());
      }).toList();
    }
    return [..._allTickets];
  }

  List<Ticket> get archievedTickets {
    if (_allTickets.isNotEmpty) {
      return _allTickets.where((ticket) {
        return DateTime.parse(formatString(ticket.journeyDate))
            .isBefore(DateTime.now());
      }).toList();
    }
    return [..._allTickets];
  }

  String formatString(String date) {
    List<String> stringList = date.split("-").reversed.toList();
    String formattedString =
        "${stringList[0]}-${stringList[1]}-${stringList[2]}";
    return formattedString;
  }
}
