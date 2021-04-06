import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';


class ApplicationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final application = Provider.of<Application>(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(application.applicationID),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          title: Text(
            application.applicationID,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          onTap: () async{
            applicationProvider.clearCurrentUser();
            await applicationProvider.getVolunteerFromApplicationVolunteerID(application.volunteerID);
            await applicationProvider.getUserFromVolunteer(applicationProvider.currentVolunteer.userId);
            Navigator.pushNamed(context, ManageApplicationPage.routeName,
                    arguments: application.applicationID);
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove this item?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          applicationProvider.deleteDocument(application.applicationID);
        }
      },
    );
  }
}