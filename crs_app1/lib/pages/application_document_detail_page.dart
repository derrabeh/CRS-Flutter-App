import 'dart:io';
import 'dart:typed_data';

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



class ViewApplicationDocumentPage extends StatefulWidget {
  static const String routeName = '/view-application-document-page';
  @override
  _ViewApplicationDocumentPageState createState() => _ViewApplicationDocumentPageState();
}

class _ViewApplicationDocumentPageState extends State<ViewApplicationDocumentPage> {
  TextEditingController dateController;
  TextEditingController typeController;
  File image;
  String documentId;
  bool isInit = true;
  String imageName;
  String url;

  void getImage() async{
    final ref = FirebaseStorage.instance.ref().child('images/$imageName');
    String location = await ref.getDownloadURL();
    setState(() {
      url = location;
    });
  }
  @override
  void didChangeDependencies(){
    if(isInit){
      final documentProvider = Provider.of<DocumentProvider>(context);
      setState(() {
        String id = ModalRoute.of(context).settings.arguments;
        Document newDocument = documentProvider.findById(id);
        imageName = newDocument.image;
        documentId = newDocument.documentID;
        dateController = TextEditingController(text: newDocument.expireDate);
        typeController = TextEditingController(text: newDocument.documentType);
        getImage();
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Document'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text('Document Type:'),
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Document Type',
                          enabled: false,
                      ),
                      controller: typeController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text('Expiry Date:'),
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expiry Date',
                        enabled: false,
                      ),
                      controller: dateController,
                    ),
                  ),
                ],
              ),
              //set a image row
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: url==null? Text('')
                    :Center(
                  child: Image.network(url),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}