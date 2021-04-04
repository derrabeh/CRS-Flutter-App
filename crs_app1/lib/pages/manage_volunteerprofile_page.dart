import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/document_add_page.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';
import 'package:crs_app/providers/user_provider.dart';

class ManageProfilePage extends StatefulWidget {
  static const String routeName = '/ManageProfile-Page';
  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController addressController;
  bool isInit = true;

  @override
  void didChangeDependencies(){
    if(isInit){
      UserProvider userProvider = Provider.of<UserProvider>(context);
      VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
      setState(() {
        User newUser = userProvider.currentUser;
        volunteerProvider.getVolunteerById(newUser.id);
        Volunteer newVolunteer = volunteerProvider.currentVolunteer;
        usernameController = TextEditingController(text:newUser.username);
        passwordController = TextEditingController(text:newUser.password);
        nameController = TextEditingController(text:newUser.name);
        phoneController = TextEditingController(text:newUser.phone);
        emailController = TextEditingController(text:newVolunteer.email);
        addressController = TextEditingController(text:newVolunteer.address);
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
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
                      );
                      Volunteer newVolunteer = Volunteer(
                        userId: newUser.id,
                        email: emailController.text,
                        address: addressController.text,
                        volunteerId: volunteerProvider.currentVolunteer.volunteerId,
                      );
                      User user = userProvider.currentUser;
                      Volunteer volunteer = volunteerProvider.currentVolunteer;
                      if(user.password != newUser.password || user.name != newUser.name
                      || user.phone != newUser.phone || volunteer.email != newVolunteer.email
                      || volunteer.address != newVolunteer.address){
                        await userProvider.updateUser(newUser);
                        await volunteerProvider.updateVolunteer(newVolunteer);
                        userProvider.currentUser = newUser;
                        volunteerProvider.currentVolunteer = newVolunteer;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Change successfully'),
                          ),
                        );
                      }
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