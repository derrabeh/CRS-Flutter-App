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
import 'package:crs_app/pages/volunteer_detail.dart';
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

//use in displaying individual volunteers in volunteers report
class VolunteerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uProvider = Provider.of<UserProvider>(context);
    final user  = Provider.of<User>(context);

    return Dismissible(
      key: ValueKey(user.id),
      background: Container(
        color: Colors.cyan,
      ),
      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.person, size: 30),
            color: Colors.grey[700],
            onPressed: (){

            },
          ),
          title: Text(user.name, style: TextStyle(
            fontSize: 24,
          )),
          trailing: IconButton(
            icon: Icon(Icons.read_more, size: 30),
            color: Colors.grey[700],
            onPressed: (){
              Navigator.pushNamed(context, VolunteerDetail.routeName,
                  arguments: user.id
              );
            },
          ),
          onTap: (){
            print(user.name);
            //expand and show more information about the volunteer
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){

      },
    );
  }
}
