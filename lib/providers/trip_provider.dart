import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crs_app/models/trip.dart';
import 'package:http/http.dart' as http;

class TripProvider with ChangeNotifier {
  List<Trip> _tripList = [];

  //get to do list
  List<Trip> get tripList {
    return [..._tripList]; //the 3 dots with Clone of the list
  }

  void clearTripList() {
    _tripList = [];
  }

  //find by id method
  Trip findById(String tripID) {
    return _tripList.firstWhere((trip) => trip.tripID == tripID);
  }

  //get all
  Future<void> getAllTrip(String userId) async {
    //firebase link/trips(is table name).json
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/trips.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Trip> loadingTrip = [];
      if (extractedData.length > 0) {
        extractedData.forEach((tripID, tripData) {
          Trip newTrip = Trip(
              tripID: tripID,
              description: tripData['description'],
              crisisType: tripData['crisisType'],
              tripDate: tripData['tripDate'],
              location: tripData['location'],
              numVolunteer: tripData['numVolunteer'],
              userId: tripData['userId']
          );
          if (newTrip.userId == userId) {
            loadingTrip.add(newTrip);
          }
        });
        _tripList = loadingTrip;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  //add method
  Future<void> addTrip(Trip trip) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/trips.json';
    try {
      final response = await http.post(url,
          body: json.encode({

            'description': trip.description,
            'crisisType': trip.crisisType,
            'tripDate': trip.tripDate,
            'location' : trip.location,
            'numVolunteer': trip.numVolunteer,
            'userId': trip.userId,

          }
          ));
      final newTrip = Trip(
        tripID: json.decode(response.body)['name'],
        description: trip.description,
        crisisType: trip.crisisType,
        tripDate: trip.tripDate,
        location : trip.location,
        numVolunteer: trip.numVolunteer,
      );
      _tripList.add(newTrip);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //update method
  Future<void> updateTrip(Trip trip) async {
    final tripIndex = _tripList.indexWhere((element) => element.tripID == trip.tripID);

    //after the table put ths (object).id to pass id
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/trips/${trip
        .tripID}.json';
    await http.patch(url,
        body: json.encode({

          'description': trip.description,
          'crisisType': trip.crisisType,
          'tripDate': trip.tripDate,
          'location' : trip.location,
          'numVolunteer': trip.numVolunteer,
        }
        ));
    _tripList[tripIndex] = trip;
    notifyListeners();
  }

  //delete method
  Future<void> deleteTrip(String tripID) async {
    //here we can directly get id no need object because we put the parameter as id not object
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/trips/$tripID.json';
    await http.delete(url);
    _tripList.removeWhere((element) => element.tripID == tripID);
    notifyListeners();
  }

}