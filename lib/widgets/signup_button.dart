import 'package:flutter/material.dart';

class SignUpEmail extends StatelessWidget {
  final String text;
  final Function onpressed;

  SignUpEmail({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Color(0xfffa6b6b),
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextButton(
        onPressed: () => onpressed(),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSans',
              fontSize: 20),
        ),
      ),
    );
  }
}
