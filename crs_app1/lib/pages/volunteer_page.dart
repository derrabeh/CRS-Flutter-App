import 'package:crs_app/pages/application_trip_history_page.dart';
import 'package:crs_app/pages/application_trip_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/login_page.dart';
class VolunteerPage extends StatefulWidget {
  static const String routeName = '/Volunteer-Page';
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
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
        title: Text('Volunteer Page'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Hello ${userProvider.currentUser.username}'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign out'),
              onTap: (){
                userProvider.currentUser = null;
                Navigator.of(context).pushReplacementNamed(
                    LoginPage.routeName
                );
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
                child: Text('Manage Profile'),
                onPressed: (){
                  Navigator.pushNamed(context, ManageProfilePage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Apply Trip'),
                onPressed: (){
                  Navigator.pushNamed(context, ApplyTripPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('View Application Status'),
                onPressed: (){
                  Navigator.pushNamed(context, ApplicationTripViewPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('View Application history'),
                onPressed: (){
                  Navigator.pushNamed(context, ApplicationTripHistoryPage.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
