import 'package:crs_system/models/user.dart';
import 'package:crs_system/pages/document_add_page.dart';
import 'package:crs_system/pages/volunteer_document_page.dart';
import 'package:crs_system/providers/application_provider.dart';
import 'package:crs_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProfilePage extends StatelessWidget {
  static const String routeName = '/ManageProfile-Page';
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ApplicationProvider a = Provider.of<ApplicationProvider>(context);
    User newUser = userProvider.currentUser;
    TextEditingController usernameController = TextEditingController(text:newUser.username);
    TextEditingController passwordController = TextEditingController(text:newUser.password);
    TextEditingController nameController = TextEditingController(text:newUser.name);
    TextEditingController phoneController = TextEditingController(text:newUser.phone);
    TextEditingController emailController = TextEditingController(text:newUser.email);
    TextEditingController addressController = TextEditingController(text:newUser.address);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Profile'),
        actions: [
          TextButton(
            child: Text('My Document',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentPage()));
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
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
                enabled: false,
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
                    child: Text('Change Profile'),
                  ),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    if(usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        addressController.text.isNotEmpty){
                      //create user object for add user
                      User newUser = User(
                        id: userProvider.currentUser.id,
                        username: usernameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        address: addressController.text,
                        userType: 'Volunteer'
                      );
                      await userProvider.updateUser(newUser);
                      userProvider.currentUser = newUser;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Change successfully'),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Must fill all column'),
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
