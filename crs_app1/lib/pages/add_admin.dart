import 'package:crs_app/models/admin.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AddAdmin extends StatelessWidget {
  static const String routeName = '/add-admin';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dateJoinedController = TextEditingController();
  TextEditingController userTypeController = TextEditingController()..text = 'admin';

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new CRS admin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                controller: usernameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
                controller: phoneController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Position',
                ),
                controller: positionController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date Joined',
                      ),
                      controller: dateJoinedController,
                    ),
                  ),
                  IconButton(
                    color: Colors.cyan,
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      dateJoinedController.text = formatDate(
                        DateTime.now(),
                        [dd,'-',mm,'-',yyyy],
                      );;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('Add Admin'),
                  ),
                  onPressed: () async{
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    //check the input is empty or not
                    if(usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        positionController.text.isNotEmpty &&
                        dateJoinedController.text.isNotEmpty &&
                        userTypeController.text.isNotEmpty
                    ){
                      //create user object for add user
                      User newUser = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        userType: userTypeController.text,
                      );

                      final isUserExist = await userProvider.isUserExist(usernameController.text);
                      if(isUserExist == false){
                        //add user
                        final response = await userProvider.addUser(newUser);
                        if(response.id != null) {
                          //create volunteer object for add volunteer
                          Admin newAdmin = Admin(
                            userId: response.id,
                            position: positionController.text,
                            dateJoined: dateJoinedController.text,
                          );
                          //add volunteer
                          adminProvider.addAdmin(newAdmin);
                          Navigator.pop(context);
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User name taken, choose another'),
                          ),
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill out all fields'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
