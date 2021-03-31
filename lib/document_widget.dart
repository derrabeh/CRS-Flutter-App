import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/models/document.dart';

class DocumentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);
    final document = Provider.of<Document>(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(document.documentID),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36,vertical: 8),
        child: ListTile(
          title: Text(
            document.documentType,
            style: TextStyle(
              fontSize: 24,
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
            },
          ),
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
        }
      },
    );
  }
}

