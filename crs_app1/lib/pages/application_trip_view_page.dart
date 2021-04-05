import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/widget/aplication_trip_for_view.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/widget/trip_widget1.dart';
import 'package:provider/provider.dart';

class ApplicationTripViewPage extends StatefulWidget {
  static const String routeName = '/application-Trip-List-page';

  @override
  _ApplicationTripViewPageState createState() => _ApplicationTripViewPageState();
}

class _ApplicationTripViewPageState extends State<ApplicationTripViewPage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    volunteerProvider.getVolunteerById(userProvider.currentUser.id);
    ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context);
    if (isInit) {
      setState(() {
        Provider.of<ApplicationProvider>(context)
            .getApplicationForVolunteer(volunteerProvider.currentVolunteer.volunteerId)
            .then((value) {
          setState(() {
          });
        });
        Provider.of<TripProvider>(context).clearTripList();
        if(applicationProvider.applicationList.length>0){
          applicationProvider.applicationList.forEach((application) {
            Provider.of<TripProvider>(context).getAllApplicationTrip(application);
          });
        }
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final tripList = tripProvider.tripList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Applied Trip List'),
      ),

      body: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: tripList[i],
          child: Column(
            children: [
              ApplicationTripViewWidget(),
              Divider(thickness: 1, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}