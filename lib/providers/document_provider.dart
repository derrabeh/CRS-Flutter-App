import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crs_app/models/document.dart';
import 'package:crs_app/models/user.dart';

class DocumentProvider with ChangeNotifier {
  List<Document> _documentList = [];
  User currentUser;


  List<Document> get documentList{
    return [..._documentList]; //the 3 dots will Clone of the _toDoList list
  }

  void clearToDoList(){
    _documentList = [];
  }

  Document findById(String id){
    return _documentList.firstWhere((document) => document.documentID == id);
  }

  Future<void> getAllDocument(String userId) async{
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/documents.json';
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Document> loadingDocument = [];
      if(extractedData.length>0) {
        extractedData.forEach((documentId, documentData) {
          Document newDocument = Document(
              documentID: documentId,
              documentType: documentData['documentType'],
              expireDate: documentData['expireDate'],
              image: documentData['image'],
              volunteerID: documentData['volunteerID']
          );
          if(newDocument.volunteerID == userId) {
            loadingDocument.add(newDocument);
          }
        });
        _documentList = loadingDocument;
        notifyListeners();
      }
    }catch(error){
      print(error);
    }
  }

  Future<Document> addDocument(Document document) async {
    String url = 'https://crs1-ae1ae-default-rtdb.firebaseio.com/documents.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'documentType': document.documentType,
            'expireDate' : document.expireDate,
            'image' : document.image,
            'volunteerID' : document.volunteerID
          }));
      final newDocument = Document(
          documentID: json.decode(response.body)['name'],
          documentType: document.documentType,
          expireDate: document.expireDate,
          image: document.image
      );
      _documentList.add(newDocument);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  Future<void> updateDocument(Document document) async {
    final documentIndex = _documentList.indexWhere((element) => element.documentID == document.documentID);
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/documents/${document.documentID}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'documentType': document.documentType,
            'expireDate': document.expireDate,
            'image': document.image,
            'volunteerID': document.volunteerID
          }));
      _documentList[documentIndex] = document;
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
  Future<void> deleteDocument(String id) async {
    String url =
        'https://crs1-ae1ae-default-rtdb.firebaseio.com/documents/$id.json';
    try {
      await http.delete(url);
      _documentList.removeWhere((element) => element.documentID == id);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}