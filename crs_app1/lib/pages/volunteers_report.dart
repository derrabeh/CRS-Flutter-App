import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';
import 'package:crs_app/pages/application_document_detail_page.dart';
import 'package:crs_app/pages/application_volunteer_document.dart';
import 'package:crs_app/pages/document_detail_page.dart';
import 'package:crs_app/pages/manager_page.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
import 'package:crs_app/widget/volunteer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/pages/document_add_page.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/admin_home_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';

class VolunteerReport extends StatefulWidget {
  static const String routeName = 'volunteer-report';
  @override
  _VolunteerReportState createState() => _VolunteerReportState();
}

class _VolunteerReportState extends State<VolunteerReport> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit){
      setState(() {
        Provider.of<UserProvider>(context).getAllVolunteer().then((value) {
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
    final userProvider = Provider.of<UserProvider>(context);
    final userList = userProvider.userList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Volunteers Report'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(Icons.sort),
              onPressed: (){
                print(userProvider.userList);
                //sort the volunteers alphabetically
                //notify listeners
              },
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: userList[i],
          child: Column(
            children: [
              VolunteerWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
