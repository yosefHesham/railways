import 'package:flutter/material.dart';

class Ticket {
  String trainNo;
  String source;
  String destination;
  String bookingdate;
  String bookingTime;
  String fareClass;
  String journeyDate;
  String journeyEndsAt;
  String journeyStartsAt;
  int noOfStops;

  num price;

  Ticket({
    @required this.trainNo,
    @required this.source,
    @required this.destination,
    @required this.price,
    @required this.bookingTime,
    @required this.bookingdate,
    @required this.journeyDate,
    @required this.journeyEndsAt,
    @required this.journeyStartsAt,
    @required this.noOfStops,
    @required this.fareClass,
  });

  Ticket.fromMap(Map<String, dynamic> ticketMap) {
    this.trainNo = ticketMap['trainNo'];
    this.source = ticketMap['source'];
    this.destination = ticketMap['destination'];
    this.price = ticketMap['price'];
    this.bookingdate = ticketMap['bookingDate'];
    this.bookingTime = ticketMap['bookingTime'];
    this.journeyDate = ticketMap['journeyDate'];
    this.journeyStartsAt = ticketMap['journeyStartsAt'];
    this.journeyEndsAt = ticketMap['journeyEndsAt'];
    this.noOfStops = ticketMap['numberOfStops'];
    this.fareClass = ticketMap["fareClass"];
  }

  Map<String, dynamic> toMap(Ticket ticket) {
    Map<String, dynamic> ticketMap = {};
    ticketMap['trainNo'] = ticket.trainNo;
    ticketMap['source'] = ticket.source;
    ticketMap['destination'] = ticket.destination;
    ticketMap['price'] = ticket.price;
    ticketMap['bookingDate'] = ticket.bookingdate;
    ticketMap['bookingTime'] = ticket.bookingTime;
    ticketMap['journeyDate'] = ticket.journeyDate;
    ticketMap['journeyStartsAt'] = ticket.journeyStartsAt;
    ticketMap['journeyEndsAt'] = ticket.journeyEndsAt;
    ticketMap['fareClass'] = ticket.fareClass;
    ticketMap['numberOfStops'] = ticket.noOfStops;

    return ticketMap;
  }
}
