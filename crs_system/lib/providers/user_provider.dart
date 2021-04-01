import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_system/models/user.dart';

class UserProvider with ChangeNotifier {
  User currentUser;

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
              password: userdata['password']
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
            'email' : user.email,
            'address' : user.address,
            'name' : user.name,
            'phone' : user.phone,
            'userType' : user.userType
          }));
      final newUser = User(
        id: json.decode(response.body)['name'],
        username: user.username,
        password: user.password,
        email: user.email,
        address: user.address,
        name: user.name,
        phone: user.phone,
        userType: user.userType
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
            'email' : user.email,
            'address' : user.address,
            'name' : user.name,
            'phone' : user.phone,
            'userType' : user.userType
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