import 'package:crs_app/pages/boarddirectory_home_page.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/manage_home_page.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';


class ManagerSignUpPage extends StatelessWidget {
  static const String routeName = '/msignup-page';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //TextEditingController emailController = TextEditingController();
  //TextEditingController addressController = TextEditingController();
  TextEditingController dateJoinedController = TextEditingController();
  TextEditingController positionController = TextEditingController()..text = 'Manager';
  TextEditingController userTypeController = TextEditingController()..text = 'Manager';



  // showDate() async{
  //   final DateTime newDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2017,7),
  //     lastDate: DateTime(2022,7),
  //     helpText: 'Select a date',
  //   );
  //   setState(() {
  //     eController.text = formatDate(
  //       newDate,
  //       [dd,'-',mm,'-',yyyy],
  //     );
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
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

              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('Add New Member'),
                  ),
                  onPressed: () async{
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    //check the input is empty or not
                    if(usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                       // emailController.text.isNotEmpty &&
                        //addressController.text.isNotEmpty &&
                        positionController.text.isNotEmpty &&
                        userTypeController.text.isNotEmpty
                    ){
                      //create user object for add user
                      User newUser = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        //email: emailController.text,
                        //address: addressController.text,
                        //position: positionController.text,
                        userType: userTypeController.text,
                      );
                      final isUserExist = await userProvider.isUserExist(usernameController.text);
                      if(isUserExist == false){
                        //add user
                        final response = await userProvider.addUser(newUser);
                        if(response.id != null) {
                          //create volunteer object for add volunteer
                          User newUser = User(
                            id: response.id,
                          );
                          //add volunteer
                         userProvider.addUser(newUser);
                          Navigator.pushReplacementNamed(context, BDHomePage.routeName);
                          //back to login
                          //Navigator.pop(context);
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User name exist'),
                          ),
                        );
                      }
                    }
                    else{
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