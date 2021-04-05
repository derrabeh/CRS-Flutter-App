import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/login_page.dart';

class ManagerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final sProvider = Provider.of<StaffProvider>(context);
    final tProvider = Provider.of<TripProvider>(context);
    final vProvider = Provider.of<VolunteerProvider>(context);
    final uProvider = Provider.of<UserProvider>(context);
    //^change to staffProvider later

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${uProvider.currentUser.username}'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: (){
              uProvider.currentUser = null;
              tProvider.clearTripList();
              Navigator.of(context).pushReplacementNamed(
                  LoginPage.routeName
              );
            },
          ),
        ],
      ),
    );
  }
}
