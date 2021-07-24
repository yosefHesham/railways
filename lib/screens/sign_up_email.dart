import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/signUp_form_validator.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/widgets/custom_text_field.dart';
import 'package:railways/widgets/signup_button.dart';

class SignUpEmailScreen extends StatefulWidget {
  static const routeName = 'signUp';
  const SignUpEmailScreen({Key key}) : super(key: key);

  @override
  _SignUpEmailScreenState createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    String name, mail, password;
    final _mailFocusNode = FocusNode();
    final _paswordFocusNode = FocusNode();

    void _saveName(String value) {
      setState(() {
        name = value;
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

    return Scaffold(
      appBar: AppBar(
        // bottomOpacity:   0.5,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        title: Text(
          'Create account',
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
            }),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  icon: null,
                  hintText: "Enter your name",
                  onFieldSubmit: _saveName,
                  inputAction: TextInputAction.next,
                  validateField: SignUpFormValidator.validateName,
                  changeFocus: () {
                    FocusScope.of(context).requestFocus(_mailFocusNode);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  focusNode: _mailFocusNode,
                  inputAction: TextInputAction.next,
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
                  focusNode: _paswordFocusNode,
                  icon: null,
                  hintText: "Enter your password",
                  inputAction: TextInputAction.go,
                  onFieldSubmit: _savePassword,
                  validateField: SignUpFormValidator.validatePassword,
                ),
                SizedBox(
                  height: 30,
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SignUpButton(
                        onpressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .signUp(
                                      name: name,
                                      email: mail,
                                      password: password);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              ScaffoldMessenger.maybeOf(context).showSnackBar(
                                  SnackBar(content: Text("Already in use")));
                            }
                          }
                        },
                        text: 'Sign up',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
