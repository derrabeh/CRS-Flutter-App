import 'dart:convert';
import 'package:crs_app/models/admin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/user.dart';

class AdminProvider with ChangeNotifier {
  Admin currentAdmin;
  List<Admin> _adminList = [];

  //use in manage admin page
  List<Admin> get adminList{
    return [... _adminList]; //return a clone of the list
  }

  //use in admin details page
  Admin findById(String aid){
    return _adminList.firstWhere((admin) => admin.adminId == aid);
  }

  //when signing out, clear out the local admin list
  //use in manager drawer widget, sign out icon
  void clearAdminList() {
    _adminList = [];
  }

  String getPosition(String uid){
    getAllAdmin();
    Admin u = _adminList.firstWhere((admin) => admin.userId == uid);
    return u.position;
  }

  Future<Admin> getAdminById(String userid) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/admin.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if(extractedData.length>0) {
        extractedData.forEach((adminId,adminData) {
          Admin a = Admin(
            adminId: adminId,
            position: adminData['position'],
            dateJoined: adminData['dateJoined'],
            userId: adminData['userId'],
          );
          if(a.userId == userid) {
            currentAdmin = a;
          }
        });
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
    return currentAdmin;
  }

  //get all admins, use in manage admin
  Future<void> getAllAdmin() async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/admin.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Admin> loadingAdmin = [];
      if (extractedData.length > 0) {
        extractedData.forEach((adminId, adminData) {
          Admin a = Admin(
              adminId: adminId,
              position: adminData['position'],
              dateJoined: adminData['dateJoined'],
              userId: adminData['userId']
          );
          loadingAdmin.add(a);
        });
        _adminList = loadingAdmin;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addAdmin(Admin a) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/admin.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'userId' : a.userId,
            'position' : a.position,
            'dateJoined' : a.dateJoined,
          }));
      final newAdmin = Admin(
        adminId: json.decode(response.body)['name'],
        position: a.position,
        dateJoined: a.dateJoined,
        userId: a.userId,
      );
      currentAdmin = newAdmin;
      notifyListeners();

    } catch (error) {
      print(error);
    }
  }

  Future<void> updateAdmin(Admin a) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers/${a.adminId}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'dateJoined' : a.dateJoined,
            'position' : a.position,
          }));
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  Future<void> deleteAdmin(String id) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/admin/$id.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  Future<void> deleteAdminFromUser(Admin a) async {
    String url = 'https://todo-20c46-default-rtdb.firebaseio.com/users/${a.userId}.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

}