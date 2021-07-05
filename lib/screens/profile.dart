import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/screens/sign_up.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: Provider.of<AuthProvider>(context, listen: false).authState,
        builder: (context, snapShot) {
          print("data ${snapShot.data} ");
          return snapShot.data == null
              ? SignUpScreen()
              : Scaffold(
                  body: Center(
                  child: TextButton(
                    child: Text('Sign Out'),
                    onPressed: () async {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                    },
                  ),
                ));
        });
  }
}
