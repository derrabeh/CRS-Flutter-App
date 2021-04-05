import 'package:flutter/material.dart';

class Admin extends ChangeNotifier{
  final adminId;
  final String position;
  final String dateJoined;
  final userId;

  Admin({
    this.adminId,
    @required this.position,
    @required this.dateJoined,
    this.userId,
  });
}
