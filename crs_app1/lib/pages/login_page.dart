import 'package:flutter/material.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/pages/trip_page.dart';

import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/pages/admin_home_page.dart';

import 'manager_page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
 // TextEditingController userTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80,bottom: 10),
                child: Image(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2.2,
      ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                  ),
                  labelText: 'Username',
                ),
                controller: usernameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                  ),
                  labelText: 'Password',

                ),
                obscureText: true,
                controller: passwordController,

              ),
              SizedBox(
                height: 20,
              ),

              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text('Login'),
                  ),
                  onPressed: () async{
                    final response = await userProvider.login(
                      usernameController.text,
                      passwordController.text,

                    );
                    if(response != null){
                      usernameController.text = '';
                      passwordController.text = '';
                      if(userProvider.currentUser.userType == 'Volunteer'){
                      Navigator.pushReplacementNamed(context,
                          VolunteerPage.routeName);}

                      else if (userProvider.currentUser.userType == 'admin'){
                        Navigator.pushReplacementNamed(context,
                            AdminHomePage.routeName);
                      }
                      else if (userProvider.currentUser.userType == 'Manager'){
                        Navigator.pushReplacementNamed(context,
                            ManagerPage.routeName);
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('UserName or Password are wrong , please enter again'),
                        ),
                      );
                    }
                  },
                ),
              ),

              IntrinsicWidth(
                stepWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(

                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Sign Up'),
                    ),
                    onPressed: () async{
                      Navigator.pushNamed(context, SignUpPage.routeName);
                      }

                  ),
                ),
              ),
              // TextButton(
              //   child: Text(
              //     'Sign Up',
              //     style: TextStyle(
              //       decoration: TextDecoration.underline,
              //       color: Colors.blue[700],
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, SignUpPage.routeName);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}


