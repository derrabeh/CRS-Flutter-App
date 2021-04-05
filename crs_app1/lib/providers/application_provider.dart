import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/document.dart';
import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/models/volunteer.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/models/trip.dart';

class ApplicationProvider with ChangeNotifier {
  List<Application> _applicationList = [];


  List<Application> get applicationList{
    return [..._applicationList]; //the 3 dots will Clone of the _toDoList list
  }

  void clearToDoList(){
    _applicationList = [];
  }

  void clearCurrentUser(){
    currentUser = null;
  }

  Application findById(String id){
    return _applicationList.firstWhere((application) => application.applicationID == id);
  }


  Volunteer currentVolunteer;
  //volunteerID is application volunteerID
  //this function is to set the current volunteer
  Future<Volunteer> getVolunteerFromApplicationVolunteerID(String id) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/volunteers.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData.length>0) {
        extractedData.forEach((volunteerID,volunteerData) {
          Volunteer newVolunteer = Volunteer(
            volunteerId: volunteerID,
            userId: volunteerData['userId'],
          );
          if(newVolunteer.volunteerId==id){
            currentVolunteer = newVolunteer;
          }
        });
        notifyListeners();
      }
      return currentVolunteer;
    }catch(error){
      print(error);
    }
  }

  User currentUser;
  //this function is using currentVolunteer to set the currentUser
  //userID is currentUser.userID
  Future<void> getUserFromVolunteer(String id) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/users.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData.length>0) {
        extractedData.forEach((userID,userData) {
          User newUser = User(
            id: userID,
            username: userData['username'],
            password: userData['password'],
            phone: userData['phone'],
            name: userData['name'],
          );
          if(newUser.id == id){
            currentUser = newUser;
          }
        });
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
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
  Future<void> getAllApplicationForAdmin(String tripID) async{
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
          if(applicationData['tripID'] == tripID ) {
           if (applicationData['status'] == 'NEW' ||
               applicationData['status'] == 'ACCEPTED') {
              loadingApplication.add(newApplication);
            }
          }
        });
        _applicationList = loadingApplication;
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
  }

  Future<void> getApplicationForVolunteer(String volunteerID) async{
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
          if(newApplication.volunteerID == volunteerID) {
            loadingApplication.add(newApplication);
          }
        });
        _applicationList = loadingApplication;
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
  }

  Future<void> getApplicationOfTrip(String volunteerID, String tripID) async{
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
          if(newApplication.volunteerID == volunteerID && newApplication.tripID == tripID) {
            loadingApplication.add(newApplication);
          }
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

      //  if (application.status == 'NEW' ||
      //      application.status == 'ACCEPTED') {


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
