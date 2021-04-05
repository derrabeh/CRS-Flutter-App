import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/widget/trip_widget1.dart';
import 'package:crs_app/widget/view_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/widget/application_widget.dart';



class ViewHistoryPage extends StatefulWidget {
  static const String routeName = '/ViewHistory-page';
  @override
  _ViewHistoryPageState createState() => _ViewHistoryPageState();
}

class _ViewHistoryPageState extends State<ViewHistoryPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    String id = ModalRoute.of(context).settings.arguments;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    volunteerProvider.getVolunteerById(userProvider.currentUser.id);
    if (isInit) {
      setState(() {
        print(volunteerProvider.currentVolunteer.volunteerId);
        Provider.of<ApplicationProvider>(context)
            .getApplicationOfTrip(volunteerProvider.currentVolunteer.volunteerId,id)
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
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final applicationList = applicationProvider.applicationList;
    return Scaffold(
      appBar: AppBar(
        title:Text('View History'),
      ),
      body: ListView.builder(
        itemCount: applicationProvider.applicationList.length,
        itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
          value: applicationList[i],
          child: Column(
            children: [
              ViewHistoryWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
