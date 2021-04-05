import 'dart:io';
import 'dart:typed_data';

import 'package:crs_app/models/application.dart';
import 'package:crs_app/models/trip.dart';
import 'package:crs_app/pages/admin_application_listpage.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/models/document.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class ApplicationStatusPage extends StatefulWidget {
  static const String routeName = '/application-status-page';
  @override
  _ApplicationStatusPageState createState() => _ApplicationStatusPageState();
}

class _ApplicationStatusPageState extends State<ApplicationStatusPage> {
  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context);
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    String id = ModalRoute.of(context).settings.arguments;
    Application newApplication = applicationProvider.findById(id);
    Trip newTrip = tripProvider.findById(newApplication.tripID);
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Container(
                height: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Trip Description:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(newTrip.description,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Trip Date:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 225,
                      child: Text(newTrip.tripDate,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Status:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 225,
                      child: Text(newApplication.status,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //set a image row
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Remark:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 225,
                      child: Text(newApplication.remarks == ''? 'No Remark' : newApplication.remarks,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}