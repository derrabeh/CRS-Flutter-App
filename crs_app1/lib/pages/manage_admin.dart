import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';
import 'package:crs_app/pages/application_document_detail_page.dart';
import 'package:crs_app/pages/application_volunteer_document.dart';
import 'package:crs_app/widget/admin_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';

import 'add_admin.dart';


class ManageAdmin extends StatefulWidget {
  static const String routeName = 'manage-admin';
  @override
  _ManageAdminState createState() => _ManageAdminState();
}

class _ManageAdminState extends State<ManageAdmin> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit){
      setState(() {
        Provider.of<UserProvider>(context).getAllAdmin().then((value) {
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
    final userList = userProvider.userList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Manage Admin'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print(userList.length);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAdmin()));
              },
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: userList[i],
          child: Column(
            children: [
              AdminWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
