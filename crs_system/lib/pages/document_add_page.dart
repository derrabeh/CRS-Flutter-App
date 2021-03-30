import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:crs_system/providers/user_provider.dart';
import 'package:crs_system/providers/volunteer_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:crs_system/models/document.dart';
import 'package:crs_system/providers/document_provider.dart';


class AddDocumentPage extends StatefulWidget {
  static const String routeName = '/add-document-page';
  @override
  _AddDocumentPageState createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  TextEditingController dateController = TextEditingController();
  String type = 'Passport';

  List<DropdownMenuItem<String>> documentType = [
    DropdownMenuItem(
      child: Text('Passport'),
      value: 'Passport',
    ),
    DropdownMenuItem(
      child: Text('Certificate'),
      value: 'Certificate',
    ),
    DropdownMenuItem(
      child: Text('Visa'),
      value: 'Visa',
    ),
  ];

  showDate() async{
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017,7),
      lastDate: DateTime(2022,7),
      helpText: 'Select a date',
    );
    setState(() {
      dateController.text = formatDate(
        newDate,
        [dd,'-',mm,'-',yyyy],
      );
    });
  }

  File image;
  selectImage() async{
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }

  String imageName;
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(image.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('images/$fileName');
    setState(() {
      imageName = fileName;
    });
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );

  }

  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Document'),
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
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    value: type,
                    elevation: 20,
                    onChanged: (String newValue){
                      setState(() {
                        type = newValue;
                      });
                    },
                    items: documentType,
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
                      ),
                      controller: dateController,
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      showDate();
                    },
                  ),
                ],
              ),
              //set a image row
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Select image'),
                onPressed: (){
                  selectImage();
                },
              ),
              image==null ? Center(
                child: Text('Select Image'),)
                  :Image.file(image),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: IntrinsicWidth(
                      child: ElevatedButton(
                        child: Text('Add Document'),
                        onPressed: (){
                          uploadImageToFirebase(context);
                          Document newDocument = Document(
                            documentID: '',
                            documentType: type,
                            expireDate: dateController.text,
                            image: imageName,
                            volunteerID: volunteerProvider.currentVolunteer.volunteerId,
                          );
                          documentProvider.addDocument(newDocument);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: IntrinsicWidth(
                      child: ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
