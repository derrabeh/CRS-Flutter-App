import 'package:crs_system/models/document.dart';
import 'package:crs_system/pages/document_add_page.dart';
import 'package:crs_system/providers/document_provider.dart';
import 'package:crs_system/providers/user_provider.dart';
import 'package:crs_system/providers/volunteer_provider.dart';
import 'package:crs_system/widget/document_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentPage extends StatefulWidget {
  static const String routeName = '/Document-page';
  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<DocumentPage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      final volunteerProvider = Provider.of<VolunteerProvider>(context);
      setState(() {
        Provider.of<DocumentProvider>(context)
            .getAllDocument(volunteerProvider.currentVolunteer.volunteerId)
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
    final userProvider = Provider.of<UserProvider>(context);
    final documentList = documentProvider.documentList;
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      appBar: AppBar(
        title:Text('All Document'),
        actions: [
          CircleAvatar(
            radius: 22,
            child: IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddDocumentPage()));
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: documentProvider.documentList.length,
        itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
          value: documentList[i],
          child: Column(
            children: [
              DocumentWidget(),
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

