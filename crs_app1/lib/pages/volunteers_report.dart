import 'package:crs_app/widget/volunteer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';

class VolunteerReport extends StatefulWidget {
  static const String routeName = 'volunteer-report';
  @override
  _VolunteerReportState createState() => _VolunteerReportState();
}

class _VolunteerReportState extends State<VolunteerReport> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit){
      setState(() {
        Provider.of<UserProvider>(context).getAllVolunteer().then((value) {
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
    final userProvider = Provider.of<UserProvider>(context);
    final userList = userProvider.userList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Volunteers Report'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(Icons.sort),
              onPressed: (){
                print(userProvider.userList);
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
              VolunteerWidget(),
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
