import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/application_volunteer_document.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/application_provider.dart';


class ManageApplicationPage extends StatefulWidget {
  static const String routeName = '/manage-application-page';
  @override
  _ManageApplicationPageState createState() => _ManageApplicationPageState();
}

class _ManageApplicationPageState extends State<ManageApplicationPage> {
  bool isInit = true;
  TextEditingController remarksController;
  TextEditingController dateController;
  TextEditingController tripIDController;
  TextEditingController volunteerController;
  TextEditingController statusController;
  @override
  void didChangeDependencies(){
    if(isInit){
      ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context);
      setState(() {
        String id = ModalRoute.of(context).settings.arguments;
        Application newApplication = applicationProvider.findById(id);
        remarksController =  TextEditingController(text: newApplication.remarks);
        dateController = TextEditingController(text: newApplication.applicationDate);
        tripIDController = TextEditingController(text: newApplication.tripID);
        volunteerController = TextEditingController(text: newApplication.volunteerID);
        statusController = TextEditingController(text: newApplication.status);
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    String id = ModalRoute.of(context).settings.arguments;
    Application newApplication = applicationProvider.findById(id);
    final newVolunteer = applicationProvider.getVolunteerFromApplicationVolunteerID(newApplication.volunteerID);
    if(newVolunteer != null) {
      applicationProvider.getUserFromVolunteer(applicationProvider.currentVolunteer.userId);
    }
    TextEditingController phoneController = TextEditingController(text: applicationProvider.currentUser.phone);
    TextEditingController nameController = TextEditingController(text: applicationProvider.currentUser.name);
    TextEditingController rejectController = TextEditingController()..text = 'REJECTED';
    TextEditingController acceptController = TextEditingController()..text = 'ACCEPTED';
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Application Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'volunteerID',
                  ),
                  controller: volunteerController,

                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Name',
                  enabled: false,
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Phone Num',
                  enabled: false,
                ),
                controller: phoneController,
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
                  enabled: false,
                ),
                controller: statusController,
              ),
              SizedBox(
                height: 20,
              ),
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Text('View Volunteer Document'),
                  onPressed: (){
                    Navigator.pushNamed(context, ApplicationVolunteerDocumentPage.routeName);
                  },
                ),
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
                        child: Text('Accepted'),
                        onPressed: () {
                          Application newApplication = Application(
                            applicationID: id,
                            applicationDate: dateController.text ,
                            volunteerID: volunteerController.text,
                            tripID: tripIDController.text,
                            remarks : remarksController.text,
                            status: acceptController.text,

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
                        child: Text('Rejected'),
                        onPressed: () {
                          Application newApplication = Application(
                            applicationID: id,
                            applicationDate: dateController.text ,
                            volunteerID: volunteerController.text,
                            tripID: tripIDController.text,
                            remarks : remarksController.text,
                            status: rejectController.text,

                          );
                          //call method
                          applicationProvider.updateApplication(newApplication);
                          applicationProvider.clearToDoList();
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
