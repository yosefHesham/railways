import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/signUp_form_validator.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/widgets/custom_text_field.dart';
import 'package:railways/widgets/signup_button.dart';

class CustomAlertDialog extends StatefulWidget {
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  void _saveName(String value) {
    setState(() {
      name = value;
      print("Name $name");
    });
  }

  void _saveMail(String value) {
    setState(() {
      mail = value;
    });
  }

  void _savePassword(String value) {
    setState(() {
      password = value;
    });
  }

  var formKey = GlobalKey<FormState>();

  FocusNode _mailFocusNode;

  FocusNode _paswordFocusNode;

  String name;

  String mail;

  String password;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.cancel_sharp),
                      onPressed: () => Navigator.of(context).pop())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                changeFocus: (_) {
                  FocusScope.of(context).requestFocus(_mailFocusNode);
                },
                inputAction: TextInputAction.next,
                hintText: "name",
                validateField: SignUpFormValidator.validateName,
                onFieldSubmit: _saveName,
                icon: null,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                changeFocus: (_) {
                  FocusScope.of(context).requestFocus(_paswordFocusNode);
                },
                hintText: "email",
                inputAction: TextInputAction.next,
                validateField: SignUpFormValidator.validateMail,
                icon: null,
                onFieldSubmit: _saveMail,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "password",
                onFieldSubmit: _savePassword,
                validateField: SignUpFormValidator.validatePassword,
                icon: null,
              ),
              SizedBox(
                height: 10,
              ),
              SignUpButton(
                text: "Create account",
                onpressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    Navigator.of(context).pop();
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signUp(name: name, email: mail, password: password);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
