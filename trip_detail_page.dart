import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class TripDetailPage extends StatelessWidget {
  static const String routeName = '/todo-detail-page';

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final tripProvider = Provider.of<TripProvider>(context);

    Trip newTrip = tripProvider.findById(id);
    TextEditingController descriptionController =
    TextEditingController(text: newTrip.description);
    TextEditingController tripDateController =
    TextEditingController(text: newTrip.tripDate);
    TextEditingController locationController =
    TextEditingController(text: newTrip.location);
    TextEditingController numVolunteerController =
    TextEditingController(text: newTrip.numVolunteer);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Trip'),
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
                        child: Text('Update ToDo'),
                        onPressed: () {
                          Trip newTrip = Trip(
                            tripID: id,
                            description: descriptionController.text,
                            tripDate: tripDateController.text,
                            location: locationController.text,
                            numVolunteer: numVolunteerController.text,
                          );
                          //call method
                          tripProvider.updateTrip(newTrip);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: IntrinsicWidth(
                      stepWidth: double.infinity,
                      child: ElevatedButton(
                        child: Text('Cancel'),
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
