import 'package:flutter/material.dart';
import 'package:railways/model/ticket.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/duration_widget.dart';

// ignore: must_be_immutable
class TicketCard extends StatelessWidget {
  Ticket ticket;

  TicketCard(this.ticket);
  @override
  Widget build(BuildContext context) {
    return buildTicketCard(context, ticket);
  }
}

Card buildTicketCard(BuildContext context, Ticket ticket) {
  return Card(
      child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ticket.trainNo,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${ticket.source} --> ${ticket.destination}",
                    style: TextStyle(
                        color: Public.accent,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              TripDuration(
                toTime: ticket.journeyEndsAt.split(" ")[0],
                fromTime: ticket.journeyStartsAt.split(" ")[0],
                date: ticket.journeyDate,
                numOfStops: ticket.noOfStops.toString(),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )));
}
