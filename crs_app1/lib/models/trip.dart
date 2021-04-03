import 'package:crs_app/models/volunteer.dart';
import 'package:flutter/material.dart';

class Trip with ChangeNotifier{
  final String tripID;
  final String description;
  final String crisisType;
  final String tripDate;
  final String location;
  final String numVolunteer;
  final String userId; //id of the user who added this trip
  //final List<Volunteer> volunteersJoined;

  Trip({
    @required this.tripID,
    @required this.description,
    @required this.crisisType,
    @required this.tripDate,
    @required this.location,
    @required this.numVolunteer,
    this.userId,

  });
}