import 'package:flutter/material.dart';

class Ticket {
  String trainNo;
  String source;
  String destination;
  String date;
  num price;

  String userName;
  String userId;

  Ticket({
    @required this.trainNo,
    @required this.source,
    @required this.destination,
    @required this.price,
    @required this.userId,
    @required this.userName,
    @required this.date,
  });

  Ticket.fromMap(Map<String, dynamic> ticketMap) {
    this.trainNo = ticketMap['trainNo'];
    this.source = ticketMap['source'];
    this.destination = ticketMap['destination'];
    this.price = ticketMap['price'];
    this.userName = ticketMap['userName'];
    this.userId = ticketMap['userId'];
    this.date = ticketMap['date'];
  }

  Map<String, dynamic> toMap(Ticket ticket) {
    Map<String, dynamic> ticketMap = {};
    ticketMap['trainNo'] = ticket.trainNo;
    ticketMap['source'] = ticket.source;
    ticketMap['destination'] = ticket.destination;
    ticketMap['price'] = ticket.price;
    ticketMap['userName'] = ticket.userName;
    ticketMap['userId'] = ticket.userId;
    ticketMap['date'] = ticket.date;
    return ticketMap;
  }
}
