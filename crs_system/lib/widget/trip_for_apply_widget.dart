import 'package:crs_system/models/application.dart';
import 'package:crs_system/models/trip.dart';
import 'package:crs_system/models/volunteer.dart';
import 'package:crs_system/providers/application_provider.dart';
import 'package:crs_system/providers/trip_provider.dart';
import 'package:crs_system/providers/volunteer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

class TripWidget extends StatelessWidget {
  static final DateTime now = DateTime.now();
  static final date = formatDate(now,[dd,'-',mm,'-',yyyy],);
  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    Volunteer newVolunteer = volunteerProvider.currentVolunteer;
    final trip = Provider.of<Trip>(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 36,vertical: 8),
        child: ListTile(
          title: Text(
            //trip description
            trip.description,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add,
              size: 36,
            ),
            color: Colors.red,
            onPressed: (){
              //add application
              Application newApplication = Application(
                applicationDate: date,
                status: 'NEW',
                remarks: '',
                volunteerID: newVolunteer.volunteerId
              );
              applicationProvider.addApplication(newApplication);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add successful'),
                ),
              );
            },
          ),
          onTap: (){
            return showDialog(context: context, builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to apply this trip?'),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: (){
                    //add application
                    Application newApplication = Application(
                       applicationDate: date,
                       status: 'NEW',
                       remarks: '',
                        volunteerID: newVolunteer.volunteerId
                    );
                    applicationProvider.addApplication(newApplication);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Add successful'),
                      ),
                    );
                  },
                  child: Text('Yes'),
                ),
              ],
            ));
          },
        ),
      );
  }
}

