//Navigator.pushNamed(context, ApplyTripPage.routeName);


// import 'package:crs_app/providers/user_provider.dart';
// import 'package:crs_app/widget/application_for_view_widget.dart';
// import 'package:crs_app/widget/user_listview_widget.dart';
import 'package:crs_app/pages/manager_signup_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/widget/user_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        Provider.of<UserProvider>(context).getAllManager().then((value) => {
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
    final userList = userProvider.userList;
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
                    MaterialPageRoute(builder: (context) => ManagerSignUpPage()));
              },
            ),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: userProvider.userList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: userProvider.userList[i],
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