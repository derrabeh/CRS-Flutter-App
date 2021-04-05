import 'package:crs_app/models/application.dart';
import 'package:crs_app/pages/application_status_page.dart';
import 'package:crs_app/providers/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ViewApplicationWidget extends StatelessWidget {
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
          onTap: () {
            Navigator.pushNamed(context, ApplicationStatusPage.routeName,
                arguments: application.applicationID);
          },
        ),
      ),
    );
  }
}