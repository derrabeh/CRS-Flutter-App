import 'package:crs_app/pages/application_document_detail_page.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/models/document.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';
import 'package:crs_app/pages/document_detail_page.dart';


class ApplicationDocumentWidget extends StatefulWidget {
  @override
  _ApplicationDocumentWidgetState createState() => _ApplicationDocumentWidgetState();
}

class _ApplicationDocumentWidgetState extends State<ApplicationDocumentWidget> {
  String url;
  void getImage(context) async{
    final document = Provider.of<Document>(context);
    String imageName = document.image;
    final ref = FirebaseStorage.instance.ref().child('images/$imageName');
    String location = await ref.getDownloadURL();
    setState(() {
      url = location;
    });
  }

  @override
  Widget build(BuildContext context){
    final document = Provider.of<Document>(context);
    getImage(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(document.documentID),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36,vertical: 8),
        child: ListTile(
          title: Container(
            alignment: Alignment.topLeft,
            width: 100,
            height: 100,
            child: url==null? Text(''): Image.network(url),
          ),
          subtitle:Text(
            document.documentType,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, ViewApplicationDocumentPage.routeName,
                arguments:document.documentID);
          },
        ),
      ),
    );
  }
}