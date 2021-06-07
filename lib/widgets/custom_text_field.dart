import 'package:flutter/material.dart';
import 'package:railways/public/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key key,
      @required this.icon,
      @required this.hintText,
      this.onFieldTap,
      this.onFieldSubmit,
      @required this.controller})
      : super(key: key);

  final IconData icon;
  final String hintText;
  final Function onFieldTap;
  final TextEditingController controller;
  final Function onFieldSubmit;

  @override
  Widget build(BuildContext context) {
    final textFieldMargin = const EdgeInsets.only(top: 8);

    print(hintText);
    return Builder(builder: (ctx) {
      return Container(
        // padding: textFieldPadding,

        margin: textFieldMargin,
        height: 40,
        width: MediaQuery.of(ctx).size.width * .95,
        child: TextField(
          style: TextStyle(color: Public.hintTextFieldColor),
          controller: controller,
          onSubmitted: (v) {},
          onTap: onFieldTap,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: hintText,
              hintStyle: TextStyle(color: Public.hintTextFieldColor),
              prefixIcon: Icon(
                icon,
                color: Public.textFieldColor,
                size: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Public.textFieldColor),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Public.textFieldFillColor)),
              filled: true,
              fillColor: Public.textFieldFillColor,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Public.textFieldFillColor),
                  borderRadius: BorderRadius.circular(8))),
        ),
      );
    });
  }
}
