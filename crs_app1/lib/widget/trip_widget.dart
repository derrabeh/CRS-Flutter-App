import 'package:crs_app/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class TripWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
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
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              size: 36,
            ),
            color: Colors.red,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Trip delete successfully'),
                ),
              );
              tripProvider.deleteTrip(trip.tripID);
            },
          ),
          onTap: () {
            Navigator.pushNamed(context, TripDetailPage.routeName,
                arguments: trip.tripID);
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove this item?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Trip delete successfully'),
            ),
          );
          tripProvider.deleteTrip(trip.tripID);
        }
      },
    );
  }
}