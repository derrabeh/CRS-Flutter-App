import 'package:crs_app/pages/manage_admin.dart';
import 'package:crs_app/pages/trip_report.dart';
import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/pages/volunteers_report.dart';
import 'package:crs_app/providers/staff_provider.dart';
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
import 'package:crs_app/pages/view_managerlist_page.dart';

import 'manager_signup_page.dart';

class BDHomePage extends StatefulWidget {
  static const String routeName = '/BDHome-Page';
  @override
  _BDHomePageState createState() => _BDHomePageState();
}

class _BDHomePageState extends State<BDHomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      final userProvider = Provider.of<UserProvider>(context);
      setState(() {
        Provider.of<VolunteerProvider>(context)
            .getVolunteerById(userProvider.currentUser.id)
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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Board Directory Home Page'),
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
                child: Text('Add Manager'),
                onPressed: (){
                  Navigator.pushNamed(context, ManagerSignUpPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('View Managers'),
                onPressed: (){
                  Navigator.pushNamed(context, ManagerListPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
