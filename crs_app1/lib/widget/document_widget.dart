import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/models/document.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';
import 'package:crs_app/pages/document_detail_page.dart';

class DocumentWidget extends StatefulWidget {
  @override
  _DocumentWidgetState createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  String url;
  void getImage(context) async{
    final documentProvider = Provider.of<DocumentProvider>(context);
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
    final documentProvider = Provider.of<DocumentProvider>(context);
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
          subtitle:Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              document.documentType,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              size: 36,
            ),
            color: Colors.red,
            onPressed: (){
              documentProvider.deleteDocument(document.documentID);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document delete'),
                ),
              );
            },
          ),
          onTap: (){
            Navigator.pushNamed(context, ManageDocumentPage.routeName,
                arguments:document.documentID);
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove this item'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context,false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context,true);
              },
              child: Text('Yes'),
            ),
          ],
        ));
      },
      onDismissed: (direction){
        if(direction == DismissDirection.endToStart){
          documentProvider.deleteDocument(document.documentID);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Document delete'),
            ),
          );
        }
      },
    );
  }
}