import 'dart:convert';

import 'package:crs_app/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/user.dart';


class VolunteerProvider with ChangeNotifier {
  Volunteer currentVolunteer;
  List<Volunteer> _volunteerList = [];

  //use in volunteer report page
  List<Volunteer> get volunteerList{
    return [... _volunteerList]; //return a clone of the list
  }

  //use in volunteer details page
  Volunteer findById(String volId){
    return _volunteerList.firstWhere((vol) => vol.volunteerId == volId);
  }

  //when signing out, clear out the local volunteer lost
  //use in manager drawer widget, sign out icon
  void clearVolunteerList() {
    _volunteerList = [];
  }

  Future<Volunteer> getVolunteerById(String userid) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if(extractedData.length>0) {
        extractedData.forEach((volunteerId,volunteerData) {
          Volunteer newVolunteer = Volunteer(
            volunteerId: volunteerId,
            email: volunteerData['email'],
            address: volunteerData['address'],
            userId: volunteerData['userId'],
          );
          if(newVolunteer.userId == userid) {
            currentVolunteer = newVolunteer;
          }
        });
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
    return currentVolunteer;
  }

  Future<void> addVolunteer(Volunteer volunteer) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'userId' : volunteer.userId,
            'email' : volunteer.email,
            'address' : volunteer.address,
          }));
      final newVolunteer = Volunteer(
        volunteerId: json.decode(response.body)['name'],
        address: volunteer.address,
        email: volunteer.email,
        userId: volunteer.userId,
      );
      currentVolunteer = newVolunteer;
      notifyListeners();

    } catch (error) {
      print(error);
    }
  }
  Future<void> updateVolunteer(Volunteer volunteer) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers/${volunteer.volunteerId}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'email' : volunteer.email,
            'address' : volunteer.address,
          }));
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  Future<void> deleteVolunteer(String id) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers/$id.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  //delete corresponding user id from user database
  //must use together with deleteVolunteer() function
  Future<void> deleteVolunteerFromUser(Volunteer vol) async {
    String url = 'https://todo-20c46-default-rtdb.firebaseio.com/users/${vol.userId}.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

}