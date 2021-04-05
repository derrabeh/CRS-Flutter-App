import 'package:flutter/material.dart';

class User extends ChangeNotifier{

  final String id;
  final String username;
  final String password;
  final String name;
  final String phone;
  final String userType; //volunteer, admin, manager, board directory


  User({
    this.id,
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.phone,
    @required this.userType,
  });

}
