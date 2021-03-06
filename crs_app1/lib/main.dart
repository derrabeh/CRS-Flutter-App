import 'package:crs_app/pages/add_admin.dart';
import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/pages/admin_manageapplication_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';
import 'package:crs_app/pages/application_document_detail_page.dart';
import 'package:crs_app/pages/application_status_page.dart';
import 'package:crs_app/pages/application_trip_history_page.dart';
import 'package:crs_app/pages/application_trip_view_page.dart';
import 'package:crs_app/pages/application_volunteer_document.dart';
import 'package:crs_app/pages/boarddirectory_home_page.dart';
import 'package:crs_app/pages/document_detail_page.dart';
import 'package:crs_app/pages/editManager.dart';
import 'package:crs_app/pages/edit_admin.dart';
import 'package:crs_app/pages/manage_admin.dart';
import 'package:crs_app/pages/manager_page.dart';
import 'package:crs_app/pages/manager_signup_page.dart';
import 'package:crs_app/pages/signup_volunteer.dart';
import 'package:crs_app/pages/trip_details.dart';
import 'package:crs_app/pages/trip_report.dart';
import 'package:crs_app/pages/view_application_status.dart';
import 'package:crs_app/pages/view_history_page.dart';
import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/pages/volunteer_detail.dart';
import 'package:crs_app/pages/volunteers_report.dart';
import 'package:crs_app/providers/staff_provider.dart';
import 'package:crs_app/widget/application_trip_for_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_add_page.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';
import 'package:crs_app/pages/volunteer_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/pages/document_add_page.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/admin_home_page.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';

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
          create: (context) => StaffProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.orange[900],
        ),
        initialRoute: LoginPage.routeName,
        routes: {
          TripReport.routeName:(context) => TripReport(),
          VolunteerDetail.routeName:(context) => VolunteerDetail(),
          VolunteerReport.routeName:(context) => VolunteerReport(),
          ManagerPage.routeName:(context) => ManagerPage(),
          TripPage.routeName: (context) => TripPage(),
          AddTripPage.routeName: (context) => AddTripPage(),
          TripDetailPage.routeName: (context) => TripDetailPage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          AdminHomePage.routeName: (context) => AdminHomePage(),
          TripListPage.routeName: (context) => TripListPage(),
          VolunteerPage.routeName:(context) => VolunteerPage(),
          ManageProfilePage.routeName:(context) => ManageProfilePage(),
          DocumentPage.routeName:(context) => DocumentPage(),
          AddDocumentPage.routeName:(context) => AddDocumentPage(),
          ApplyTripPage.routeName:(context) => ApplyTripPage(),
          ApplicationListPage.routeName:(context) => ApplicationListPage(),
          ManageDocumentPage.routeName:(context) => ManageDocumentPage(),
          ManageApplicationPage.routeName:(context) => ManageApplicationPage(),
          ApplicationVolunteerDocumentPage.routeName:(context) => ApplicationVolunteerDocumentPage(),
          ViewApplicationDocumentPage.routeName:(context) => ViewApplicationDocumentPage(),
          ManagerListPage.routeName:(context) => ManagerListPage(),
          ApplicationTripHistoryPage.routeName: (context) => ApplicationTripHistoryPage(),
          ApplicationTripViewPage.routeName:(context) => ApplicationTripViewPage(),
          ApplicationStatusPage.routeName:(context) => ApplicationStatusPage(),
          ViewApplicationPage.routeName: (context) => ViewApplicationPage(),
          ViewHistoryPage.routeName: (context) => ViewHistoryPage(),
          BDHomePage.routeName: (context) => BDHomePage(),
          EditManagerProfilePage.routeName: (context) =>EditManagerProfilePage(),
          ManagerSignUpPage.routeName: (context) => ManagerSignUpPage(),
          AddAdmin.routeName:(context) => AddAdmin(),
          EditAdmin.routeName:(context) => EditAdmin(),
          ManageAdmin.routeName:(context) => ManageAdmin(),
          TripDetails.routeName:(context) => TripDetails(),
        },
      ),
    );
  }
}
