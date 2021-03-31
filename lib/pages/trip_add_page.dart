import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/trip_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AddTripPage extends StatefulWidget {
  static const String routeName = '/addTrip-page';
  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController tripDateController = TextEditingController();
  //  TextEditingController crisisTypeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController numVolunteersController = TextEditingController();

  String type1 = 'FLOOD';



  List<DropdownMenuItem<String>> crisisType = [
    DropdownMenuItem(
      child: Text('FLOOD'),
      value: 'FLOOD',
    ),
    DropdownMenuItem(
      child: Text('EARTHQUAKE'),
      value: 'EARTHQUAKE',
    ),
    DropdownMenuItem(
      child: Text('WILDFIRE'),
      value: 'WILDFIRE',
    ),
  ];

  showDate() async{
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017,7),
      lastDate: DateTime(2022,7),
      helpText: 'Select a date',
    );
    setState(() {
      tripDateController.text = formatDate(
        newDate,
        [dd,'-',mm,'-',yyyy],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);


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
              Row(
                children: [

                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Trip Date',
                      ),
                      controller: tripDateController,
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      showDate();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text('Crisis Type:'),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    value: type1,
                    elevation: 20,
                    onChanged: (String newValue){
                      setState(() {
                        type1 = newValue;
                      });
                    },
                    items: crisisType,
                  ),
                ],
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
                  labelText: 'Number of Volunteers',
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
                              crisisType: type1,
                              tripDate: tripDateController.text,
                              location: locationController.text,
                              numVolunteer: numVolunteersController.text,
                              userId: userProvider.currentUser.id
                          );
                          //call method
                          tripProvider.addTrip(newTrip);
                          Navigator.pushReplacementNamed(context, TripPage.routeName);
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
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
