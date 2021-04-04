
import 'package:crs_app/widget/trip_report_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/trip_provider.dart';

class TripReport extends StatefulWidget {
  static const String routeName = 'trip-report';
  @override
  _TripReportState createState() => _TripReportState();
}

class _TripReportState extends State<TripReport> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit){
      setState(() {
        Provider.of<TripProvider>(context).getAllTrips().then((value) {
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
    final tripProvider = Provider.of<TripProvider>(context);
    final tripList = tripProvider.tripList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Trips Report'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(Icons.sort),
              onPressed: (){
                print(tripProvider.tripList);
                //sort the trips by date

              },
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: tripList[i],
          child: Column(
            children: [
              TripReportWidget(),
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
