import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/helpers/signUp_form_validator.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/widgets/custom_text_field.dart';

class BasicInfoScreen extends StatefulWidget {
  static const routeName = "/basicInfo";

  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  String name;
  String mail;
  void saveName(String name) {
    name = name;
  }

  void saveMail(String mail) {
    mail = mail;
  }

  final formKey = GlobalKey<FormState>();

  void showAlertDialog(TextEditingController controller, String title) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              content: _buildCustomTextField(
                  nameController, "eg ah", SignUpFormValidator.validateName),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic info"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildTile(user.displayName, "Name:", null),
            _buildTile(user.email, "Email", null),
            Center(
              child: TextButton.icon(
                  onPressed: () => null,
                  icon: Icon(Icons.delete),
                  label: Text("Delete Account")),
            )
          ],
        ),
      ),
    );
  }

  _buildCustomTextField(
      TextEditingController controller, String hint, final Function validate) {
    return Form(
        key: formKey,
        child: CustomTextField(
          icon: null,
          hintText: hint,
          validateField: validate,
        ));
  }
}

Widget _buildTile(
  String title,
  String lable,
  Function onEdit,
) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("$lable ")),
              Expanded(
                flex: 2,
                child: Text(title),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => null,
                ),
              )
            ],
          ),
          Divider(
            endIndent: 2,
            indent: 2,
          )
        ],
      ),
    ),
  );
}
