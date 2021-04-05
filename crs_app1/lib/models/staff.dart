import 'package:flutter/material.dart';

class Staff extends ChangeNotifier{

  final String staffID;
  final String position;
  final String dateJoined;
  final bool suspend;
  final String userID;

  Staff({
    this.staffID,
    @required this.position,
    @required this.dateJoined,
    @required this.userID,
    @required this.suspend,
  });

}
