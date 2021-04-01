import 'package:crs_system/models/application.dart';
import 'package:crs_system/models/volunteer.dart';
import 'package:crs_system/pages/document_add_page.dart';
import 'package:crs_system/providers/application_provider.dart';
import 'package:crs_system/providers/document_provider.dart';
import 'package:crs_system/providers/trip_provider.dart';
import 'package:crs_system/providers/user_provider.dart';
import 'package:crs_system/providers/volunteer_provider.dart';
import 'package:crs_system/widget/document_widget.dart';
import 'package:crs_system/widget/trip_for_apply_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyTripPage extends StatefulWidget {
  static const String routeName = '/ApplyTrip-page';
  @override
  _ApplyTripState createState() => _ApplyTripState();
}

class _ApplyTripState extends State<ApplyTripPage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      setState(() {
        Provider.of<TripProvider>(context)
            .getAllTripForApply()
            .then((value) {
          setState(() {
            isInit = false;
          });
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);
    final tripList = tripProvider.tripList;
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      appBar: AppBar(
        title:Text('Apply Trip'),
      ),
      body: ListView.builder(
        itemCount: tripProvider.tripList.length,
        itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
          value: (tripList)[i],
          child: Column(
            children: [
              TripWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

