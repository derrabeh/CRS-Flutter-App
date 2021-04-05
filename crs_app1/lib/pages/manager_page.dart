import 'package:crs_app/pages/manage_admin.dart';
import 'package:crs_app/pages/trip_report.dart';
import 'package:crs_app/pages/volunteers_report.dart';
import 'package:crs_app/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';

class ManagerPage extends StatefulWidget {
  static const String routeName = '/Manager-Page';
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Page'),
      ),
      drawer: UserDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Generate Volunteers Report'),
                onPressed: (){
                  Navigator.pushNamed(context, VolunteerReport.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Manage CRS Adminstrators'),
                onPressed: (){
                  Navigator.pushNamed(context, ManageAdmin.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Generate Trips Report'),
                onPressed: (){
                  Navigator.pushNamed(context, TripReport.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
