import 'package:crs_app/models/admin.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/volunteer_detail.dart';
import 'package:crs_app/providers/admin_provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';

class AdminWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uProvider = Provider.of<UserProvider>(context);
    final aProvider = Provider.of<AdminProvider>(context);
    final user  = Provider.of<User>(context);

    return Card(
      key: ValueKey(user.id),
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
                onPressed: (){},
                icon: Icon(Icons.assignment_ind)
            ),
            title: Text(user.name),
            subtitle: Text('Working as '),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Staff has joined CRS since '),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text('Suspend',
                          style: TextStyle(
                            fontSize: 16.0,
                          ))
                  ),
                  TextButton(
                      onPressed: () {},
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
                      //print(uProvider.getPhone(admin.userId));
                      //String phone = uProvider.getPhone(admin.userId);
                      //print(phone);
                      //UrlLauncher.launch('tel://$phone');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
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
