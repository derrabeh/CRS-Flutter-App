import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class TripDetails extends StatelessWidget {
  static const String routeName = '/trip-details';

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final tripProvider = Provider.of<TripProvider>(context);

    Trip trip = tripProvider.findById(id);
    TextEditingController descriptionController = TextEditingController(
        text: trip.description);
    TextEditingController tripDateController = TextEditingController(
        text: trip.tripDate);
    TextEditingController crisisTypeController = TextEditingController(
        text: trip.crisisType);
    TextEditingController locationController = TextEditingController(
        text: trip.location);
    TextEditingController numVolunteerController = TextEditingController(
        text: trip.numVolunteer);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                controller: descriptionController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'TripDate',
                ),
                controller: tripDateController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                ),
                controller: locationController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NumVolunteers',
                ),
                controller: numVolunteerController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('View Applications'),
                        onPressed: () {
                          //insert code to view applications
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
