import 'package:flutter/material.dart';

class Trip with ChangeNotifier{
  final String tripID;
  final String description;
  final String crisisType;
  final String tripDate;
  final String location;
  final String numVolunteer;
  final String userId;

  Trip({
    this.tripID,
    @required this.description,
    @required this.crisisType,
    @required this.tripDate,
    @required this.location,
    @required this.numVolunteer,
    this.userId,



  });
}