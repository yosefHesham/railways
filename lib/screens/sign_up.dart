import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/sign_in_screen.dart';
import 'package:railways/screens/sign_up_email.dart';
import 'package:railways/widgets/signup_button.dart';
import 'package:railways/widgets/signup_button_social.dart';

class SignUpScreen extends StatelessWidget {
  // const SignUpScreen({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        title: Text(
          'Create an account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSans',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'For faster booking',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'For live journey updates ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'For travelling your way ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                GoogleSignButton(
                  text: 'Continue with Google ',
                  onPressed: () async {
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .googleSignIn();
                    } catch (e) {
                      showSnackBar(context, e);
                    }
                  },
                  // onPressed: (){
                  //   // final provider = Provider.of<GoogleSignInProvider>(context ,listen: false);
                  //   // provider.login();
                  // },
                ),
                SizedBox(
                  height: 30,
                ),
                SignUpButton(
                  text: 'Sign Up with Email',
                  onpressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, SignUpEmailScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Aleardy have an account ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xfffa6b6b),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Public.textFieldFillColor,
      content: Text(
        e.toString(),
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    ));
  }
}
