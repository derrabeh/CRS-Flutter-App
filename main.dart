import 'package:crs_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/admin_home_page.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/pages/trip_detail_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TripProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.orange[900],
        ),
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          AddTripPage.routeName: (context) => AddTripPage(),
          TripDetailPage.routeName: (context) => TripDetailPage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignUpPage.routeName: (context) => SignUpPage(),

        },
      ),
    );
  }
}
