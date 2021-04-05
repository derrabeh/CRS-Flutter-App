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
          subtitle: Text(
            'Trip Date : ${trip.tripDate}',
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