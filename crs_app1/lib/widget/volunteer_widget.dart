import 'package:crs_app/models/user.dart';
import 'package:crs_app/pages/volunteer_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';

//use in displaying individual volunteers in volunteers report
class VolunteerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uProvider = Provider.of<UserProvider>(context);
    final user  = Provider.of<User>(context);

    return Dismissible(
      key: ValueKey(user.id),
      background: Container(
        color: Colors.cyan,
      ),
      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.person, size: 30),
            color: Colors.grey[700],
            onPressed: (){

            },
          ),
          title: Text(user.name, style: TextStyle(
            fontSize: 24,
          )),
          trailing: IconButton(
            icon: Icon(Icons.read_more, size: 30),
            color: Colors.grey[700],
            onPressed: (){
              Navigator.pushNamed(context, VolunteerDetail.routeName,
                  arguments: user.id
              );
            },
          ),
          onTap: (){
            print(user.name);
            //expand and show more information about the volunteer
          },
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){

      },
    );
  }
}
