
import 'package:crs_app/models/staff.dart';
import 'package:crs_app/pages/editManager.dart';
import 'package:crs_app/pages/edit_admin.dart';
import 'package:crs_app/providers/staff_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';


class AdminWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user  = Provider.of<User>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    return Card(
      key: ValueKey(user.id),
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
                onPressed: (){},
                icon: Icon(Icons.assignment_ind)
            ),
            title: Text(user.name + ', ' + user.phone),
            subtitle: Text('Username is ' + user.username),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Staff is a CRS admin'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,  EditAdmin.routeName,
                            arguments: user.id);
                      },
                      child: Text('Edit',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple
                          ))
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: (){
                      print(user.phone);
                      String phone = user.phone;
                      FlutterPhoneDirectCaller.callNumber(phone);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text('Do you want to remove this item?'),
                            actions: [
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () async{
                                  userProvider.deleteUser(user.id);
                                  final response =await staffProvider.findStaffByUserID(user.id);
                                  staffProvider.deleteStaff(response.staffID);
                                  userProvider.getAllAdmin();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Admin delete'),
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                },
                              ),
                            ],
                          ));
                    },
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );




  }
}
