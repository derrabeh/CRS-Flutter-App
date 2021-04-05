import 'package:crs_app/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/widget/trip_widget1.dart';
import 'package:provider/provider.dart';

class TripListPage extends StatefulWidget {
  static const String routeName = '/tripList-page';

  @override
  _TripListPageState createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final userProvider = Provider.of<UserProvider>(context);
      setState(() {
        Provider.of<TripProvider>(context).getAllTrip(userProvider.currentUser.id).then((value) => {
          setState(() {
            isInit = false;
          })
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final tripList = tripProvider.tripList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Trip List'),

      ),

      body: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: tripList[i],
          child: Column(
            children: [
              TripWidgetForApplication(),
              Divider(thickness: 1, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}