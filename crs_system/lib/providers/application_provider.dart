import 'dart:convert';
import 'package:crs_system/models/application.dart';
import 'package:crs_system/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_system/models/document.dart';

class ApplicationProvider with ChangeNotifier {
  List<Application> _applicationList = [];
  User currentUser;


  List<Application> get applicationList{
    return [..._applicationList]; //the 3 dots will Clone of the _toDoList list
  }

  void clearToDoList(){
    _applicationList = [];
  }

  Application findById(String id){
    return _applicationList.firstWhere((application) => application.applicationID == id);
  }

  Future<void> getAllApplication() async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/applications.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Application> loadingApplication = [];
      if(extractedData.length>0) {
        extractedData.forEach((applicationID,applicationData) {
          Application newApplication = Application(
              applicationID: applicationID,
              applicationDate : applicationData['applicationDate'],
              status: applicationData['status'],
              remarks: applicationData['remarks'],
              volunteerID: applicationData['volunteerID'],
              tripID: applicationData['tripID'],
          );
          loadingApplication.add(newApplication);
        });
        _applicationList = loadingApplication;
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
  }

  Future<Document> addApplication(Application application) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/applications.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'applicationDate': application.applicationDate,
            'status' : application.status,
            'remarks' : application.remarks,
            'volunteerID' : application.volunteerID,
            'tripID' : application.tripID,
          }));
      final newApplication = Application(
          applicationID: json.decode(response.body)['name'],
          applicationDate: application.applicationDate,
          status: application.status,
          remarks: application.remarks
      );
      _applicationList.add(newApplication);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  Future<void> updateApplication(Application application) async {
    final applicationIndex = _applicationList.indexWhere((element) => element.applicationID == application.applicationID);
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/applications/${application.applicationID}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'applicationDate': application.applicationDate,
            'status' : application.status,
            'remarks' : application.remarks,
            'volunteerID' : application.volunteerID,
            'tripID' : application.tripID
          }));
      _applicationList[applicationIndex] = application;
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
  Future<void> deleteDocument(String id) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/applications/$id.json';
    try {
      await http.delete(url);
      _applicationList.removeWhere((element) => element.applicationID == id);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}