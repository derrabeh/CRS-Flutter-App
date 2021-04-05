//import 'dart:js';

//import 'dart:js';

import 'package:date_format/date_format.dart';
import 'package:crs_app/pages/boarddirectory_home_page.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/manage_home_page.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';


class ManagerSignUpPage extends StatefulWidget {
  static const String routeName = '/msignup-page';
   @override
   _ManagerSignUpPageState createState() =>  _ManagerSignUpPageState();
   }

   class  _ManagerSignUpPageState extends State<ManagerSignUpPage>{
  bool isInit;
  //final userProvider = Provider.of<UserProvider>(context);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //TextEditingController emailController = TextEditingController();
  //TextEditingController addressController = TextEditingController();
  //TextEditingController tripDateController = TextEditingController(text: newTrip.tripDate);
  TextEditingController dateJoinedController = TextEditingController();
  //TextEditingController dateJoinedController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController positionController = TextEditingController()
    ..text = 'Manager';
  TextEditingController userTypeController = TextEditingController()
    ..text = 'Manager';


   showDate() async{
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017,7),
      lastDate: DateTime(2022,7),
      helpText: 'Date Joined',
    );
    setState(() {
      dateJoinedController.text = formatDate(
        newDate,
        [dd,'-',mm,'-',yyyy],
      );
    });
  }
void didChangeDependencies(){
     if(isInit){
       final userProvider = Provider.of<UserProvider>(context);
       setState(() {
         String id = ModalRoute.of(context).settings.arguments;
         // User newUser = userProvider.findById(id);
         // // username = newUser.username;
         // // password = newUser.password;
         // // name = newUser.name;
         // // phone = newUser.phone;
         // // userType = newUser.userType;
         // dateJoinedController = TextEditingController(text: newUser.dateJoined);
         // getUser();


       });
isInit = false;
super.didChangeDependencies();
     }
}

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(
        context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD NEW MEMBER'),
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
                  labelText: 'name',
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
              Row(
                children: [

                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date Joined:',
                      ),
                      controller: dateJoinedController,
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      showDate();
                    },
                  ),
                ],
              ),
              Divider(),
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'DateJoined',
              //   ),
              //   controller: dateJoinedController,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'name',
              //   ),
              //   controller: nameController,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Address',
              //   ),
              //   controller: addressController,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Position',
                  enabled: false,
                ),
                controller: positionController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UserType',
                  enabled: false,
                ),
                controller: userTypeController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remark',
                  enabled: false,
                ),
                controller: remarkController,
              ),
              SizedBox(
                height: 20,
              ),

              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('Add New Member'),
                  ),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    //check the input is empty or not
                    if (usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        dateJoinedController.text.isNotEmpty&&
                        positionController.text.isNotEmpty &&
                        userTypeController.text.isNotEmpty
                        // emailController.text.isNotEmpty &&
                        //addressController.text.isNotEmpty &&
                        // positionController.text.isNotEmpty &&
                        // userTypeController.text.isNotEmpty
                    ) {
                      //create user object for add user
                      User newUser = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        //email: emailController.text,
                        //address: addressController.text,
                        //position: positionController.text,
                        //dateJoined: dateJoinedController.text,
                        userType: userTypeController.text,
                      );
                      final isUserExist = await userProvider.isUserExist(
                          usernameController.text);
                      if (isUserExist == false) {
                        //add user
                        final response = await userProvider.addUser(newUser);
                        if (response.id != null) {
                          //create volunteer object for add volunteer
                          User newUser = User(
                            id: response.id,
                          );
                          //add volunteer
                          userProvider.addUser(newUser);
                          Navigator.pushReplacementNamed(context, BDHomePage
                              .routeName);
                          //back to login
                          //Navigator.pop(context);
                        }
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User name exist'),
                          ),
                        );
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Need to fill all column'),
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