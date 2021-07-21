import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/auth_provider.dart';
import 'package:railways/public/assets.dart';
import 'package:railways/screens/basic_info_screen.dart';
import 'package:railways/widgets/profile_tile.dart';
import 'package:railways/widgets/train_appbar.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context, listen: false).user;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            TrainAppBar(
                color: Theme.of(context).primaryColor,
                title: "Hello ${user.displayName}",
                radius: 0.0,
                image: profileBar),
            SliverList(
                delegate: SliverChildListDelegate([
              ProfileTile(
                onPress: () =>
                    onProfileTilePress(context, BasicInfoScreen.routeName),
                icon: Icons.person,
                title: "Passenger details",
              ),
              ProfileTile(
                onPress: () => onProfileTilePress(context, "/bookings"),
                icon: Icons.book,
                title: "Previous Booking",
              ),
              ProfileTile(
                onPress: () => onProfileTilePress(context, "/settings"),
                icon: Icons.settings,
                title: "Settings",
              ),
              ProfileTile(
                onPress: () => onProfileTilePress(context, "/about"),
                icon: Icons.account_balance_outlined,
                title: "About us",
              ),
              ProfileTile(
                onPress: () => onProfileTilePress(context, "contact"),
                icon: Icons.phone,
                title: "Contact us",
              ),
              ProfileTile(
                onPress: () => logout(context),
                icon: Icons.exit_to_app,
                title: "Log out",
              ),
            ]))
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).signOut();
  }

  void onProfileTilePress(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
