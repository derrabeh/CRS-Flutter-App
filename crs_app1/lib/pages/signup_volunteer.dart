import 'package:crs_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';


class SignUpPage extends StatelessWidget {
  static const String routeName = '/signup-page';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userTypeController = TextEditingController()..text = 'Volunteer';
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
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
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
                controller: addressController,
              ),
              SizedBox(
                height: 20,
              ),
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('Sign Up'),
                  ),
                  onPressed: () async{
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    //check the input is empty or not
                    if(usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        addressController.text.isNotEmpty &&
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
                          Volunteer newVolunteer = Volunteer(
                            userId: response.id,
                            email: emailController.text,
                            address: addressController.text,
                          );
                          //add volunteer
                          volunteerProvider.addVolunteer(newVolunteer);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sign Up successfully'),
                            ),
                          );
                          Navigator.pop(context);
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