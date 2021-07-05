import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:railways/public/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key key,
      @required this.icon,
      @required this.hintText,
      this.onFieldTap,
      this.validateField,
      this.onFieldSubmit,
      this.focusNode,
      this.changeFocus,
      this.inputAction,
      this.controller})
      : super(key: key);

  final IconData icon;
  final String hintText;
  final Function onFieldTap;
  final TextEditingController controller;
  final Function onFieldSubmit;
  final Function validateField;
  final FocusNode focusNode;
  final Function changeFocus;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    final textFieldMargin = const EdgeInsets.only(top: 8);

    return Builder(builder: (ctx) {
      return Container(
        // padding: textFieldPadding,

        margin: textFieldMargin,
        height: 40,
        width: MediaQuery.of(ctx).size.width * .95,
        child: TextFormField(
          focusNode: focusNode,
          style: TextStyle(color: Public.hintTextFieldColor),
          controller: controller,
          validator: (v) => validateField(v),
          onSaved: (v) => onFieldSubmit(v),
          onFieldSubmitted: (_) => changeFocus(),
          onTap: onFieldTap,
          textInputAction: inputAction,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 11, right: 3, top: 14, bottom: 14),
              errorStyle: TextStyle(fontSize: 9, height: 0.3),
              hintText: hintText,
              hintStyle: TextStyle(color: Public.hintTextFieldColor),
              prefixIcon: icon == null
                  ? null
                  : Icon(
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
