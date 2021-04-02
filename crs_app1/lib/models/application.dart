import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Application extends ChangeNotifier{

  final String applicationID;
  final String applicationDate;
  final String status;
  final String remarks;
  final String volunteerID;
  final String tripID;

  Application({
    this.applicationID,
    @required this.applicationDate,
    @required this.status,
    this.remarks,
    this.volunteerID,
    @required this.tripID,
  });
}