import 'dart:convert';

import 'package:crs_app/models/staff.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/user.dart';


class StaffProvider with ChangeNotifier {
  Staff currentStaff;
  List<Staff> _adminList = [];

  //use in manage admin page
  List<Staff> get adminList{
    return [... _adminList]; //return a clone of the list
  }

  //use in admin details page
  Staff findById(String aid){
    return _adminList.firstWhere((admin) => admin.staffID == aid);
  }

  //when signing out, clear out the local admin list
  //use in manager drawer widget, sign out icon
  void clearAdminList() {
    _adminList = [];
  }

  String getPosition(String uid){
    getAllAdmin();
    Staff u = _adminList.firstWhere((admin) => admin.userID == uid);
    return u.position;
  }

  //get all admins, use in manage admin
  Future<void> getAllAdmin() async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/admin.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Staff> loadingAdmin = [];
      if (extractedData.length > 0) {
        extractedData.forEach((staffID,staffData) {
          Staff newStaff = Staff(
              staffID: staffID,
              position: staffData['position'],
              dateJoined: staffData['dateJoined'],
              userID: staffData['userId'],
              suspend: staffData['suspend']
          );
          if(newStaff.position != 'Manager') {
            loadingAdmin.add(newStaff);
          }
        });
        _adminList = loadingAdmin;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<Staff> findStaffByUserID(String id) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/staffs.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData.length>0) {
        extractedData.forEach((staffID, staffData) {
          if(staffData['userID'] == id) {
            Staff newStaff = Staff(
              staffID: staffID,
              position: staffData['position'],
              dateJoined: staffData['dateJoined'],
              userID: staffData['userID'],
              suspend: staffData['suspend'],
            );
            currentStaff = newStaff;
          }
        });
      }
    }catch(error){
      print(error);
    }
    return currentStaff;
  }
  Future<void> addStaff(Staff staff) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/staffs.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'position' : staff.position,
            'dateJoined' : staff.dateJoined,
            'userID' : staff.userID,
            'suspend' : staff.suspend
          }));
      final newStaff = Staff(
        staffID: json.decode(response.body)['name'],
        position: staff.position,
        dateJoined: staff.dateJoined,
        userID: staff.userID,
        suspend: staff.suspend,
      );
      currentStaff = newStaff;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  Future<void> updateStaff(Staff staff) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/staffs/${staff.staffID}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'position' : staff.position,
            'dateJoined' : staff.dateJoined,
            'userID' : staff.userID,
            'suspend' : staff.suspend
          }));
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  Future<void> deleteStaff(String id) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/staffs/$id.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}