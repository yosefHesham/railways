import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/screens/booking_screen.dart';
import 'package:railways/screens/search_result.dart';
import 'package:railways/screens/search_screen.dart';
import 'package:railways/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => TrainsProvider(),
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: "Walsheim",
              primaryColor: Color(0xff132968),
              accentColor: Color(0xfffa6b6b)),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/search':
                return PageTransition(
                  duration: Duration(seconds: 2),
                  child: SearchScreen(),
                  type: PageTransitionType.bottomToTop,
                  settings: settings,
                );
                break;
              default:
                return null;
            }
          },
          home: SplashScreen(),
          // routes: {StationQuery.routeName: (ctx) => StationQuery()},
          title: 'RailWays',
          routes: {
            SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
            BookingScreen.routeName: (ctx) => BookingScreen()
          },
        ));
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       height: 200,
//       width: double.infinity,
//       child: SearchResultScreen(),
//     ));
//   }
// }

// class SecondPageRoute extends PageRouteBuilder {
//   SecondPageRoute()
//       : super(
//             pageBuilder: (BuildContext context, Animation<double> animation,
//                     Animation<double> secondaryAnimation) =>
//                 SearchScreen());

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return SlideTransition(
//       position: Tween<Offset>(begin: Offset(0, 1), end: Offset(.0, .0))
//           .animate(controller),
//       child: SearchScreen(),
//     );
//   }
// }

// class CupertinoRoute extends PageRouteBuilder {
//   final Widget enterPage;
//   final Widget exitPage;
//   CupertinoRoute({this.exitPage, this.enterPage})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) {
//             return enterPage;
//           },
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) {
//             return Stack(
//               children: <Widget>[
//                 SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(0.0, 0.0),
//                     end: const Offset(-0.33, 0.0),
//                   ).animate(
//                     CurvedAnimation(
//                       parent: animation,
//                       curve: Curves.linearToEaseOut,
//                       reverseCurve: Curves.easeInToLinear,
//                     ),
//                   ),
//                   child: exitPage,
//                 ),
//                 SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(1.0, 0.0),
//                     end: Offset.zero,
//                   ).animate(
//                     CurvedAnimation(
//                       parent: animation,
//                       curve: Curves.linearToEaseOut,
//                       reverseCurve: Curves.easeInToLinear,
//                     ),
//                   ),
//                   child: enterPage,
//                 )
//               ],
//             );
//           },
//         );
// }
