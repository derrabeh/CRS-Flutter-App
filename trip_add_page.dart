import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/admin_home_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddTripPage extends StatefulWidget {
  static const String routeName = '/add-page';
  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    TextEditingController descriptionController = TextEditingController();
    TextEditingController tripDateController = TextEditingController();
    TextEditingController crisisTypeController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController numVolunteersController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
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
                  labelText: 'Trip Date',
                ),
              //  maxLines: 1,
                controller: tripDateController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CrisisType',
                ),
                controller: crisisTypeController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'location',
                ),
                controller: locationController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Trip Date',
                ),
                controller: tripDateController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Num Volunteers',
                ),
                controller: numVolunteersController,
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
                        child: Text('Add Trip'),
                        onPressed: () {
                          Trip newTrip = Trip(
                              tripID: '',
                              description: descriptionController.text,
                              crisisType: crisisTypeController.text,
                              tripDate: tripDateController.text,
                              location: locationController.text,
                              numVolunteer: numVolunteersController.text,
                              userId: userProvider.currentUser.id
                          );
                          //call method
                          tripProvider.addTrip(newTrip);
                          Navigator.pushReplacementNamed(context, HomePage.routeName);
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
