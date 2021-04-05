import 'package:crs_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class VolunteerDetail extends StatelessWidget {
  static const String routeName = '/volunteer-detail';
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final userProvider = Provider.of<UserProvider>(context);

    User user = userProvider.findById(id);
    TextEditingController usernameController = TextEditingController(
        text: user.username
    );
    TextEditingController phoneController = TextEditingController(
        text: user.phone
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Detail'),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  controller: usernameController,
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                  controller: phoneController,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IntrinsicWidth(
                        stepWidth: double.infinity,
                        child: ElevatedButton(
                          child: Text('Contact Volunteer'),
                          onPressed: (){
                            print(user.phone);
                            String phone = user.phone;
                            FlutterPhoneDirectCaller.callNumber(phone);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: IntrinsicWidth(
                        stepWidth: double.infinity,
                        child: ElevatedButton(
                          child: Text('Back'),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}
