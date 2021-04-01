import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/application_provider.dart';

class ManageApplicationPage extends StatelessWidget {
  static const String routeName = '/manage-application-page';


  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final applicationProvider = Provider.of<ApplicationProvider>(context);

    Application newApplication = applicationProvider.findById(id);
    final newVolunteer = applicationProvider.getVolunteerFromApplicationVolunteerID(newApplication.volunteerID);
    if(newVolunteer != null) {
      applicationProvider.getUserFromVolunteer(
          applicationProvider.currentVolunteer.userId);
    }

    TextEditingController volunteerController =
    TextEditingController(text: applicationProvider.currentVolunteer.userId);

    TextEditingController remarksController =
    TextEditingController(text: newApplication.remarks);
    TextEditingController statusController =
    TextEditingController(text: newApplication.status);


    return Scaffold(
      appBar: AppBar(
        title: Text('Update Application Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'volunteer ID',

                ),
                controller: volunteerController,
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'remarks',

                ),
                controller: remarksController,
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'status',
                ),
                controller: statusController,
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Update Application Status'),
                        onPressed: () {
                          Application newApplication = Application(
                            applicationID: id,

                            remarks : remarksController.text,
                            status: statusController.text,

                          );
                          //call method
                          applicationProvider.updateApplication(newApplication);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
