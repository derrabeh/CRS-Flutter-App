//Navigator.pushNamed(context, ApplyTripPage.routeName);

import 'package:crs_app/main.dart';
import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/widget/application_for_view_widget.dart';
//import 'package:crs_app/widget/manager_view_page.dart';
import 'package:crs_app/widget/trip_widget1.dart';
import 'package:crs_app/widget/user_listview_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/widget/application_widget.dart';

class ManagerListPage extends StatefulWidget {
  static const String routeName = '/ViewMangers-page';
  @override
  _ManagerListPageState createState() => _ManagerListPageState();
}

class _ManagerListPageState extends State<ManagerListPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final userProvider = Provider.of<UserProvider>(context);
      setState(() {
        Provider.of<UserProvider>(context).getAllUser(userProvider.currentUser.id).then((value) => {
          setState(() {
            isInit = false;
          })
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    //final userProvider = Provider.of<UserProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final userList = userProvider.userData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager List'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManagerListPage()));
              },
            ),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
         value: userList[i],
          child: Column(
            children: [
              UserWidget(),
              Divider(thickness: 1, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
