import 'package:crs_app/models/staff.dart';
import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/providers/staff_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class EditManagerProfilePage extends StatelessWidget {
  static const String routeName = '/editManager-Page';
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    User newUser = userProvider.currentUser;
    staffProvider.findStaffByUserID(newUser.id);
    TextEditingController usernameController = TextEditingController(text:newUser.username);
    TextEditingController passwordController = TextEditingController(text:newUser.password);
    TextEditingController nameController = TextEditingController(text:newUser.name);
    TextEditingController phoneController = TextEditingController(text:newUser.phone);
    TextEditingController userTypeController = TextEditingController(text:newUser.userType);
    //TextEditingController addressController = TextEditingController(text:newUser.address);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Manager Profile'),
        actions: [
          TextButton(
            child: Text('My Manager',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ManagerListPage()));
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
                  labelText: 'phone',
                ),
                controller: phoneController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'userType',
                ),
                controller: userTypeController,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: IntrinsicWidth(
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
                          userTypeController.text.isNotEmpty
                         // emailController.text.isNotEmpty &&
                         // addressController.text.isNotEmpty){
                        //create user object for add user
                        ){
                        User newUser = User(
                          id: userProvider.currentUser.id,
                          username: usernameController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                          userType: userTypeController.text,
                          //email: emailController.text,
                          //address: addressController.text,
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
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: IntrinsicWidth(
                  stepWidth: double.infinity,
                  child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(staffProvider.currentStaff.suspend==false? 'Suspend': 'UnSuspend'),
                    ),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      if(usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          userTypeController.text.isNotEmpty
                      // emailController.text.isNotEmpty &&
                      // addressController.text.isNotEmpty){
                      //create user object for add user
                      ){
                        User newUser = User(
                          id: userProvider.currentUser.id,
                          username: usernameController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                          userType: userTypeController.text,
                          //email: emailController.text,
                          //address: addressController.text,
                        );
                        await userProvider.updateUser(newUser);
                        userProvider.currentUser = newUser;
                        if(staffProvider.currentStaff.suspend==false) {
                          Staff newStaff = Staff(
                            staffID: staffProvider.currentStaff.staffID,
                            position: staffProvider.currentStaff.position,
                            dateJoined: staffProvider.currentStaff.dateJoined,
                            userID: staffProvider.currentStaff.userID,
                            suspend: true,
                          );
                          staffProvider.updateStaff(newStaff);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Suspended'),
                            ),
                          );
                        }
                        else{
                          Staff newStaff = Staff(
                            staffID: staffProvider.currentStaff.staffID,
                            position: staffProvider.currentStaff.position,
                            dateJoined: staffProvider.currentStaff.dateJoined,
                            userID: staffProvider.currentStaff.userID,
                            suspend: false,
                          );
                          staffProvider.updateStaff(newStaff);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('UnSuspended'),
                            ),
                          );
                        }
                        Navigator.pop(context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}