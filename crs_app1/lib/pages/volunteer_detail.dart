import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';
import 'package:crs_app/pages/application_document_detail_page.dart';
import 'package:crs_app/pages/application_volunteer_document.dart';
import 'package:crs_app/pages/document_detail_page.dart';
import 'package:crs_app/pages/manager_page.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
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

class VolunteerDetail extends StatelessWidget {
  static const String routeName = '/volunteer-detail';
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final userProvider = Provider.of<UserProvider>(context);

    User user = userProvider.findById(id);
    TextEditingController usernameController = TextEditingController(
        text: user.username
    );
    TextEditingController phoneController = TextEditingController(
        text: user.phone
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Detail'),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  controller: usernameController,
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                  controller: phoneController,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IntrinsicWidth(
                        stepWidth: double.infinity,
                        child: ElevatedButton(
                          child: Text('Contact Volunteer'),
                          onPressed: (){
                            //insert code to contact
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: IntrinsicWidth(
                        stepWidth: double.infinity,
                        child: ElevatedButton(
                          child: Text('Back'),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}
