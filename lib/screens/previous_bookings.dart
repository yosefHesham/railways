import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/providers/tickets_provider.dart';
import 'package:railways/screens/sign_up.dart';
import 'package:railways/widgets/ticket_card.dart';

class PreviousBooking extends StatefulWidget {
  const PreviousBooking({Key key}) : super(key: key);

  @override
  _PreviousBookingState createState() => _PreviousBookingState();
}

class _PreviousBookingState extends State<PreviousBooking> {
  bool isLoading = false;
  initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration.zero).then((_) async {
        setState(() {
          isLoading = true;
        });
        await Provider.of<TicketProvider>(context, listen: false).getTickets();
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).user;
    return user == null
        ? SignUpScreen()
        : Scaffold(
            body: isLoading
                ? Center(
                    child: JumpingText(
                      "Fetching...",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : DefaultTabController(
                    length: 2,
                    child: SafeArea(
                      child: NestedScrollView(
                        body: TabBarView(
                          children: [
                            Consumer<TicketProvider>(
                              builder: (ctx, ticketProv, _) =>
                                  ticketProv.upcomingTickets == null ||
                                          ticketProv.upcomingTickets.isEmpty
                                      ? Center(
                                          child: Column(children: [
                                            Image.asset(
                                                "assets/images/ticket_upcoming.png"),
                                            Text("No upcoming tickets")
                                          ]),
                                        )
                                      : SingleChildScrollView(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .9,
                                            child: Column(
                                              children: ticketProv
                                                  .upcomingTickets
                                                  .map((e) => TicketCard(e))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                            ),
                            Consumer<TicketProvider>(
                              builder: (ctx, ticketProv, _) =>
                                  ticketProv.archievedTickets == null ||
                                          ticketProv.archievedTickets.isEmpty
                                      ? Center(
                                          child: Column(children: [
                                            Image.asset(
                                                "assets/images/ticket_archived.png"),
                                            Text("No Archieived Tickets")
                                          ]),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .9,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: ticketProv
                                                  .archievedTickets
                                                  .map((e) => TicketCard(e))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) => [
                          SliverAppBar(
                            expandedHeight:
                                MediaQuery.of(context).size.height * .4,
                            stretch: true,
                            elevation: 12.0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Container(
                                margin: EdgeInsets.only(bottom: 50, left: 20),
                                child: Text(
                                  "Your bookings",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              collapseMode: CollapseMode.parallax,
                              background: Image.asset(
                                  "assets/images/your_bookings.png"),
                            ),
                            titleSpacing: 2.0,
                            bottom: TabBar(tabs: [
                              Tab(
                                child: Text(
                                  "Upcoming",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Archieved",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
  }
}
