import 'package:crs_system/pages/apply_trip_page.dart';
import 'package:crs_system/pages/document_detail_page.dart';
import 'package:crs_system/pages/manage_profile_page.dart';
import 'package:crs_system/pages/document_add_page.dart';
import 'package:crs_system/pages/signup_page.dart';
import 'package:crs_system/pages/volunteer_page.dart';
import 'package:crs_system/pages/volunteer_document_page.dart';
import 'package:crs_system/providers/application_provider.dart';
import 'package:crs_system/providers/document_provider.dart';
import 'package:crs_system/providers/trip_provider.dart';
import 'package:crs_system/providers/user_provider.dart';
import 'package:crs_system/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DocumentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VolunteerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TripProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SignUpPage.routeName,
        routes: {
          SignUpPage.routeName:(context) => SignUpPage(),
          VolunteerPage.routeName:(context) => VolunteerPage(),
          ManageProfilePage.routeName:(context) => ManageProfilePage(),
          DocumentPage.routeName:(context) => DocumentPage(),
          AddDocumentPage.routeName:(context) => AddDocumentPage(),
          ApplyTripPage.routeName:(context) => ApplyTripPage(),
          ManageDocumentPage.routeName:(context) => ManageDocumentPage(),
        },
      ),
    );
  }
}
