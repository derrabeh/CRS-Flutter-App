import 'package:crs_app/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/trip_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final userProvider = Provider.of<UserProvider>(context);
      setState(() {
        Provider.of<TripProvider>(context).getAllTrip(userProvider.currentUser.id).then((value) => {
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
    final tripProvider = Provider.of<TripProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final tripList = tripProvider.tripList;
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('CRS App'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTripPage()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 1,
        child: ListView(
          children: [
            Container(
              height: 170,
              child: DrawerHeader(
                decoration: BoxDecoration(),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Welcome, ${userProvider.currentUser.username}',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                userProvider.currentUser = null;
                tripProvider.clearTripList();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: tripList[i],
          child: Column(
            children: [
              TripWidget(),
              Divider(thickness: 1, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}