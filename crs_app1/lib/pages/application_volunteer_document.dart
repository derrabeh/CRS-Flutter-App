import 'package:crs_app/models/application.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:crs_app/widget/application_document_widget.dart';
import 'package:crs_app/widget/document_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/models/document.dart';
import 'package:crs_app/pages/document_add_page.dart';
import 'package:crs_app/providers/document_provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:crs_app/providers/volunteer_provider.dart';
import 'package:crs_app/pages/volunteer_document_page.dart';

class ApplicationVolunteerDocumentPage extends StatefulWidget {
  static const String routeName = '/Application-Volunteer-Document-page';
  @override
  _ApplicationVolunteerDocumentPageState createState() => _ApplicationVolunteerDocumentPageState();
}

class _ApplicationVolunteerDocumentPageState extends State<ApplicationVolunteerDocumentPage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      final applicationProvider = Provider.of<ApplicationProvider>(context);
      setState(() {
        Provider.of<DocumentProvider>(context)
            .getAllDocument(applicationProvider.currentVolunteer.volunteerId)
            .then((value) {
          setState(() {
            isInit = false;
          });
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context);
    final documentList = documentProvider.documentList;
    return Scaffold(
      appBar: AppBar(
        title:Text('All Document'),
      ),
      body: ListView.builder(
        itemCount: documentProvider.documentList.length,
        itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
          value: documentList[i],
          child: Column(
            children: [
              ApplicationDocumentWidget(),
              Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}