import 'package:flutter/material.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/previous_bookings.dart';
import 'package:railways/screens/profile.dart';
import 'package:railways/screens/search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [
    SearchScreen(),
    PreviousBooking(),
    ProfileScreen(),
  ];

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Public.accent,
        onTap: (v) => changePage(v),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: FittedBox(
                child: Container(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    "assets/images/ticket.svg",
                    color: _currentIndex == 1 ? Public.accent : Colors.grey,
                    fit: BoxFit.scaleDown,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
