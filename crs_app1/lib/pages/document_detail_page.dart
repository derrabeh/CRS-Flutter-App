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



class ManageDocumentPage extends StatefulWidget {
  static const String routeName = '/manage-document-page';
  @override
  _ManageDocumentPageState createState() => _ManageDocumentPageState();
}

class _ManageDocumentPageState extends State<ManageDocumentPage> {
  TextEditingController dateController;
  String type;
  File image;
  String documentId;
  bool isInit = true;

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
  final picker = ImagePicker();
  selectImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
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

  void getImage() async{
    final ref = FirebaseStorage.instance.ref().child('images/$imageName');
    String location = await ref.getDownloadURL();
    setState(() {
      url = location;
    });
  }

  String url;
  @override
  void didChangeDependencies(){
    if(isInit){
      final documentProvider = Provider.of<DocumentProvider>(context);
      setState(() {
        String id = ModalRoute.of(context).settings.arguments;
        Document newDocument = documentProvider.findById(id);
        imageName = newDocument.image;
        documentId = newDocument.documentID;
        type=newDocument.documentType;
        dateController = TextEditingController(text: newDocument.expireDate);
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
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  child: Text('Select image'),
                  onPressed: (){
                    selectImage();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: url==null? Text('')
                    :image==null ? Center(
                  child: Image.network(url),)
                    :Image.file(image),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: IntrinsicWidth(
                      child: ElevatedButton(
                        child: Text('Change Document'),
                        onPressed: (){
                          if(image!=null){
                            StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$imageName');
                            firebaseStorageRef.delete();
                          }
                          uploadImageToFirebase(context);
                          Document newDocument = Document(
                            documentID: documentId,
                            documentType: type,
                            expireDate: dateController.text,
                            image: imageName,
                            volunteerID: volunteerProvider.currentVolunteer.volunteerId,
                          );
                          documentProvider.updateDocument(newDocument);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Update document successfully'),
                            ),
                          );
                          documentProvider.getAllDocument(volunteerProvider.currentVolunteer.volunteerId);
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