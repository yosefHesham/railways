import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/assets.dart';
import 'package:railways/screens/search_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      print("first");
      setState(() {
        _textVisible = true;
      });
      final repo = Provider.of<TrainsProvider>(context, listen: false);

      repo.getTrains().then((value) {
        Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
        setState(() {
          _textVisible = false;
        });
      });
      // Future.delayed(const Duration(seconds: 5)).then((value) {
      //   Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
      //   print("value");
      //   setState(() {
      //     print("second");
      //     _textVisible = false;
      //   });
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Container(
          child: Image.asset(
            splash,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Align(
          alignment: Alignment(0, -.5),
          child: AnimatedOpacity(
              child: Text(
                'EgyRails',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Walsheim'),
              ),
              opacity: _textVisible ? 1 : 0.00,
              duration: Duration(milliseconds: 500)),
        )
      ])),
    );
  }
}
