import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crs_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User currentUser;
  List<User> _userList = [];

  List<User> get userList{
    return [... _userList]; //return a clone of the list
  }

  User findById(String uid){
    return _userList.firstWhere((user) => user.id == uid);
  }

  void clearUserList() {
    _userList = [];
  }

  //use in manage CRS admin
  Future<void> getAllAdmin() async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.get(url);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      final List<User> staffList = [];

      if (extracted.length > 0) {
        extracted.forEach((userId, userData) {
          User user = User(
            id: userId,
            username: userData['username'],
            password: userData['password'],
            name: userData['name'],
            phone: userData['phone'],
            userType: userData['userType'],
          );
          if (user.userType == 'admin') {
            staffList.add(user);
          }
        });
        _userList = staffList;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllManager() async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try{
      final response = await http.get(url);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      final List<User> volunteerList = [];

      if(extracted.length > 0){
        extracted.forEach((userId, userData) {
          User user = User(
            id: userId,
            username: userData['username'],
            password: userData['password'],
            name: userData['name'],
            phone: userData['phone'],
            userType: userData['userType'],
          );
          if (user.userType == 'Manager'){
            volunteerList.add(user);
          }
        });
        _userList = volunteerList;
        notifyListeners();
      }
    } catch (e){
      print(e);
    }
  }

  //use in volunteer report
  Future<void> getAllVolunteer() async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try{
      final response = await http.get(url);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      final List<User> volunteerList = [];

      if(extracted.length > 0){
        extracted.forEach((userId, userData) {
          User user = User(
            id: userId,
            username: userData['username'],
            password: userData['password'],
            name: userData['name'],
            phone: userData['phone'],
            userType: userData['userType'],
          );
          if (user.userType == 'Volunteer'){
            volunteerList.add(user);
          }
        });
        _userList = volunteerList;
        notifyListeners();
      }
    } catch (e){
      print(e);
    }
  }

  //use in volunteer widget, return new user
  Future<User> getUserById(String uid) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    User newUser;
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if(extractedData.length>0) {
        extractedData.forEach((userId,userData) {
          User newUser = User(
            id: userId,
            username: userData['username'],
            password: userData['password'],
            name: userData['name'],
            phone: userData['phone'],
            userType: userData['userType'],
          );
          if(newUser.id == uid) {
            return newUser;
          }
        });
      }
    }catch(error){
      print(error);
    }
    return newUser;
  }

  Future<User> login(String username, String password) async {
    //can change the url link to your firebase link to check
    // but need add "/users.json" after the link
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null && extractedData.length > 0) {
      extractedData.forEach((userId, userdata) {
        if (userdata['username'] == username &&
            userdata['password'] == password) {
          User newUser = User(
              id: userId,
              username: userdata['username'],
              password: userdata['password'],
              name: userdata['name'],
              phone: userdata['phone'],
              userType: userdata['userType'],
          );
          currentUser = newUser;
        }
      });
    }
    //if there is no match(username and password), this method will return null
    return currentUser;
  }

  //check the user is exist or not, using in login, sign up and record crs staff
  Future<bool> isUserExist(String username) async{
    bool result = false;
    //can change the url link to your firebase link to check
    // but need add "/users.json" after the link
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if(userdata['username'] == username){
            result = true;
          }
        });
      }
    } catch (error) {
      print(error);
    }
    return result;
  }

  //this is add the user , use in sign up and record crs staff
  Future<User> addUser(User user) async {
    //can change the url link to your firebase link to check
    // but need add "/users.json" after the link
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'username': user.username,
            'password' : user.password,
            'name' : user.name,
            'phone' : user.phone,
            'userType': user.userType,
          }));
      final newUser = User(
        id: json.decode(response.body)['name'],
        username: user.username,
        password: user.password,
        name: user.name,
        phone: user.phone,
        userType: user.userType,
      );
      currentUser = newUser;
      notifyListeners();
      return currentUser;
    } catch (error) {
      print(error);
    }
  }

  //this is for update the user data(if need)
  Future<void> updateUser(User user) async {
    //can change the url link to your firebase link to check
    // but need add "/users/(userId).json" after the link
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/users/${user.id}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'username': user.username,
            'password' : user.password,
            'name' : user.name,
            'phone' : user.phone,
            'userType': user.userType,
          }));
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  //this is for delete user data(if need)
  Future<void> deleteUser(String id) async {
    //can change the url link to your firebase link to check
    // but need add "/users/(userId).json" after the link
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/users/$id.json';
    try {
      await http.delete(url);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}