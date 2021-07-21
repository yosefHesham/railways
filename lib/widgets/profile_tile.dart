import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPress;
  ProfileTile(
      {@required this.icon, @required this.title, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: () => onPress(),
              leading: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Divider(
            indent: 2,
            endIndent: 2,
          ),
        ],
      ),
    );
  }
}
