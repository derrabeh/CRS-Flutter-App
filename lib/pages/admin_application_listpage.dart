import 'package:crs_app/models/trip.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/widget/application_widget.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';

class ApplicationListPage extends StatefulWidget {
  static const String routeName = '/applicationList-page';

  @override
  _ApplicationListPageState createState() => _ApplicationListPageState();
}

class _ApplicationListPageState extends State<ApplicationListPage> {
  bool isInit = true;





  @override

  void didChangeDependencies() {
    if (isInit) {
      final applicationProvider = Provider.of<ApplicationProvider>(context);
      final userProvider = Provider.of<UserProvider>(context);
     String id = ModalRoute.of(context).settings.arguments;



      setState(() {
        Provider.of<ApplicationProvider>(context).getAllApplicationForAdmin(id).then((value) => {
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
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);
    final applicationList = applicationProvider.applicationList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Application List Page'),
        actions: [

        ],
      ),

      body: ListView.builder(
        itemCount: applicationList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: applicationList[i],
          child: Column(
            children: [
              ApplicationWidget(),
              Divider(thickness: 1, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}