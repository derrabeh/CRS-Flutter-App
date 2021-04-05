import 'package:crs_app/models/trip.dart';
import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/editManager.dart';
import 'package:crs_app/pages/view_managerlist_page.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:crs_app/pages/trip_detail_page.dart';
import 'package:crs_app/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = Provider.of<User>(context);

    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(user.id),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(

          title: Text(
            user.username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              size: 36,
            ),
            color: Colors.red,
            onPressed: () {
              userProvider.deleteUser(user.id);
            },

          ),
          onTap: () {
            Navigator.pushNamed(context,  EditManagerProfilePage.routeName,
                arguments: user.id);
          },

        ),

      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove this item?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          userProvider.deleteUser(user.id);
        }
      },
    );


  }
}