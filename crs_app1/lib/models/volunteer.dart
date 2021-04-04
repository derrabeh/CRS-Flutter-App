import 'package:flutter/material.dart';

class Volunteer extends ChangeNotifier{
  final volunteerId;
  final String email;
  final String address;
  final userId;


  Volunteer({
    this.volunteerId,
    @required this.email,
    @required this.address,
    this.userId,
  });
}
