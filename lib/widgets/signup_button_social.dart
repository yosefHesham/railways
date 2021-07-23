//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railways/public/colors.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  GoogleSignButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: Public.textFieldColor)),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Image.asset('assets/images/google.png'),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
