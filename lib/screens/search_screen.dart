import 'package:flutter/material.dart';
import 'package:railways/widgets/search_widget.dart';
import 'package:railways/widgets/train_appbar.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          slivers: [
            TrainAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([SearchWidget()]),
            )
          ],
        ),
      ),
    );
  }
}
