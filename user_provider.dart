import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crs_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User currentUser;

  Future<User> login(String username, String password) async {
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

  Future<bool> isUserExist(String username) async {
    bool result = false;

    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //print(extractedData.length);
    if (extractedData != null && extractedData.length > 0) {
      extractedData.forEach((userId, userdata) {
        if (userdata['username'] == username) {
          result = true;
        }
      });
    }
    print(result);
    return result;
  }

  Future<User> addUser(User user) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    final response = await http.post(url,
        body: json.encode({
          'username': user.username,
          'password': user.password
        })
    );
    User newUser = User(
        id: json.decode(response.body)['name'],
        username: user.username,
        password: user.password
    );
    currentUser = newUser;
    return currentUser;
  }


}