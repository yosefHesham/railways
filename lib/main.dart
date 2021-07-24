import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/providers/journey_provider.dart';
import 'package:railways/providers/tickets_provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/screens/basic_info_screen.dart';
import 'package:railways/screens/booking_screen.dart';
import 'package:railways/screens/home_screen.dart';
import 'package:railways/screens/profile.dart';
import 'package:railways/screens/search_result.dart';
import 'package:railways/screens/search_screen.dart';
import 'package:railways/screens/sign_in_screen.dart';
import 'package:railways/screens/sign_up_email.dart';
import 'package:railways/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: TrainsProvider()),
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider.value(value: JourneyProvider()),
          ChangeNotifierProvider.value(value: TicketProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
            BookingScreen.routeName: (ctx) => BookingScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SignUpEmailScreen.routeName: (ctx) => SignUpEmailScreen(),
            SignInScreen.routeName: (ctx) => SignInScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            BasicInfoScreen.routeName: (ctx) => BasicInfoScreen()
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
