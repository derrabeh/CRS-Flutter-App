import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/providers/user_provider.dart';
//zimport 'package:crs_app/widget/todo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/apply_trip_page.dart';
import 'package:crs_app/pages/manage_volunteerprofile_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/login_page.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/pages/admin_triplist_page.dart';
 import 'package:crs_app/pages/view_managerlist_page.dart';

import 'editManager.dart';

import 'manager_signup_page.dart';

class BDHomePage extends StatefulWidget {
  static const String routeName = '/BDHome-Page';
  @override
  _BDHomePageState createState() => _BDHomePageState();
}

class _BDHomePageState extends State<BDHomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      final userProvider = Provider.of<UserProvider>(context);
      setState(() {
        Provider.of<VolunteerProvider>(context)
            .getVolunteerById(userProvider.currentUser.id)
            .then((value) {
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
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Board Directory Home Page'),
      ),
      drawer: Drawer(
        elevation: 4,
        child: ListView(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      'User Name : ${userProvider.currentUser.username}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.brown,
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: (){
                userProvider.currentUser = null;
                tripProvider.clearTripList();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Add Manager'),
                onPressed: (){
                  Navigator.pushNamed(context, ManagerSignUpPage.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('View Managers'),
                onPressed: (){
                  Navigator.pushNamed(context, ManagerListPage.routeName);
                },
              ),
            ),
            Divider(),
            Container(
              height: 50,
              child: ElevatedButton(
                child: Text('Sign Out'),
                onPressed: (){
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:mytodo/pages/todo_add_page.dart';
// import 'package:mytodo/providers/todo_providers.dart';
// import 'package:mytodo/todo_widgets.dart';
// import 'package:provider/provider.dart';

// class BDHomePage extends StatefulWidget {
//   static const String routeName = '/';
//   @override
//   _BDHomePageState createState() => _BDHomePageState();
// }
//
// class _BDHomePageState extends State<BDHomePage> {
//   bool isInit = true;
//   @override
//   void didChangeDependencies() {
//     if(isInit){
//       setState(() {
//         Provider.of<ToDoProvider>(context).getAllToDo().then((value) {
//           setState(() {
//             isInit = false;
//           });
//         });
//       });
//     }
//     isInit = false;
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final toDoProvider = Provider.of<ToDoProvider>(context);
//     final toDoList = toDoProvider.toDoList;
//     return Scaffold(
//       backgroundColor: Colors.yellow[700],
//       appBar: AppBar(
//         title: Text('Board Directory Home Page'),
//         actions: [
//           CircleAvatar(
//             radius: 22,
//             child: IconButton(
//               icon: Icon(Icons.add,),
//               onPressed: (){
//                 Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => AddPage(),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//       body: ListView.builder(
//           itemCount: toDoList.length,
//           itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//             value: toDoList[i],
//             child: Column(
//                 children: [ToDoWidget(),
//                   Divider(
//                     thickness: 1,
//                     color: Colors.black54,
//
//                   )
//                 ]
//             ),
//           )
//       ),
//
//     );
//   }
// }