import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_page.dart';
class AdminHomePage extends StatefulWidget {
  static const String routeName = '/adminHome-Page';
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      drawer: Drawer(
        elevation: 4,
        child: ListView(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      'User Name : ${userProvider.currentUser.username}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.brown,
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: (){
                userProvider.currentUser = null;
                //  volunteerProvider.clearTripList();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Organize Trip'),
                onPressed: (){
                  Navigator.pushNamed(context, TripPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Manage Volunteer Applications'),
                onPressed: (){
                //  Navigator.pushNamed(context, ApplyTripPage.routeName);
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
