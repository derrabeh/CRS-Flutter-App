import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/view_application_status.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class ApplicationTripViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trip = Provider.of<Trip>(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(trip.tripID),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          title: Text(
            trip.description,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Trip Date : ${trip.tripDate}'),
              SizedBox(height: 10),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, ViewApplicationPage.routeName,
                arguments: trip.tripID);
          },
        ),
      ),
    );
  }
}