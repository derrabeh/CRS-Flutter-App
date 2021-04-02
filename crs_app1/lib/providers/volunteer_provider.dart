import 'dart:convert';

import 'package:crs_app/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/user.dart';


class VolunteerProvider with ChangeNotifier {
  Volunteer currentVolunteer;

  Future<Volunteer> getVolunteerById(String userid) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData.length>0) {
        extractedData.forEach((volunteerId,volunteerData) {
          Volunteer newVolunteer = Volunteer(
            volunteerId: volunteerId,
            userId: volunteerData['userId'],


          );
          if(newVolunteer.userId == userid) {
            currentVolunteer = newVolunteer;
          }
        });
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
          }));
      final newVolunteer = Volunteer(
        volunteerId: json.decode(response.body)['name'],
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
          }));
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  Future<void> deleteVolunteer(String id) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers/$id.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}