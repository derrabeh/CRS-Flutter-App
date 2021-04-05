import 'package:crs_app/models/admin.dart';
import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/providers/admin_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:flutter/cupertino.dart';


class EditAdmin extends StatefulWidget {
  static const String routeName = '/edit-admin';
  @override
  _EditAdminState createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit){
      setState(() {
        Provider.of<AdminProvider>(context).getAllAdmin().then((value) {
          setState(() {
            isInit = false;
          });
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AdminProvider volunteerProvider = Provider.of<AdminProvider>(context);

    String id = ModalRoute.of(context).settings.arguments;
    User user = userProvider.findById(id);
    //final aList = volunteerProvider.adminList;
    //Admin admin = aList.firstWhere((admin) => admin.userId == id);

    TextEditingController usernameController = TextEditingController(
        text: user.username
    );
    TextEditingController passwordController = TextEditingController(
        text: user.password
    );
    TextEditingController nameController = TextEditingController(
        text: user.name
    );
    TextEditingController phoneController = TextEditingController(
        text: user.phone
    );
    TextEditingController userTypeController = TextEditingController(
        text: user.userType
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Admin Profile'),
        actions: [
          TextButton(
            child: Text(' ',
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
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'phone',
              //   ),
              //   controller: phoneController,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
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
                      child: Text('Suspend'),
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
                            content: Text('Suspended'),
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
            ],
          ),
        ),
      ),
    );
  }
}