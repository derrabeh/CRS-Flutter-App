import 'package:flutter/material.dart';

class User extends ChangeNotifier{

  final String id;
  final String username;
  final String password;
  final String name;
  final String email;
  final String phone;
  final String address;

  User({
    this.id,
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.address,
  });

}
