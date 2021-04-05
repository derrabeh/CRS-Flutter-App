import 'package:crs_app/models/application.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final application = Provider.of<Application>(context);
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(application.applicationID),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          title: Text(
            application.applicationID,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Apply Date : ${application.applicationDate}'),
              SizedBox(height: 10),
              Text('Status : ${application.status}'),
              SizedBox(height: 10),
              Text('Remark : ${application.remarks == ''? 'No Remarks' : application.remarks}'),
              SizedBox(height: 10),
            ],
          ),
          onTap: () {
          },
        ),
      ),
    );
  }
}