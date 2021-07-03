import 'package:flutter/material.dart';
import 'package:railways/helpers/signUp_form_validator.dart';
import 'package:railways/widgets/custom_text_field.dart';
import 'package:railways/widgets/signup_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);
  static const routeName = 'signIn';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String mail, password;
  final _paswordFocusNode = FocusNode();
  var _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // bottomOpacity:   0.5,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        title: Text(
          'Sign In ',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  icon: null,
                  hintText: "Enter your email",
                  onFieldSubmit: _saveMail,
                  validateField: SignUpFormValidator.validateMail,
                  changeFocus: () {
                    FocusScope.of(context).requestFocus(_paswordFocusNode);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  icon: null,
                  hintText: "Enter your password",
                  onFieldSubmit: _savePassword,
                  validateField: SignUpFormValidator.validatePassword,
                  focusNode: _paswordFocusNode,
                ),
                SizedBox(
                  height: 30,
                ),
                SignUpEmail(
                  //  onpressed: () {},
                  text: 'sign in',
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
