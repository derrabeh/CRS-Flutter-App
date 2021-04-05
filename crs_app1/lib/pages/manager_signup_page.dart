import 'package:crs_app/models/staff.dart';
import 'package:crs_app/pages/boarddirectory_home_page.dart';
import 'package:crs_app/providers/staff_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';

class ManagerSignUpPage extends StatefulWidget {
  static const String routeName = '/msignup-page';
  @override
  _ManagerSignUpPageState createState() => _ManagerSignUpPageState();
}

class _ManagerSignUpPageState extends State<ManagerSignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateJoinedController = TextEditingController();
  TextEditingController positionController = TextEditingController()..text = 'Manager';



  showDate() async{
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017,7),
      lastDate: DateTime(2022,7),
      helpText: 'Select a date',
    );
    setState(() {
      dateJoinedController.text = formatDate(
        newDate,
        [dd,'-',mm,'-',yyyy],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
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
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date joined',
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
                        positionController.text.isNotEmpty &&
                        dateJoinedController.text.isNotEmpty
                    ){
                      //create user object for add user
                      User newUser = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        userType: 'Manager',
                      );
                      final isUserExist = await userProvider.isUserExist(usernameController.text);
                      if(isUserExist == false){
                        //add user
                        final response = await userProvider.addUser(newUser);
                        if(response.id != null) {
                          Staff newStaff = Staff(
                            userID: response.id,
                            position: positionController.text,
                            dateJoined: dateJoinedController.text,
                            suspend: false,
                          );
                          staffProvider.addStaff(newStaff);
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