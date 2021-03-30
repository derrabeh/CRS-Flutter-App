import 'package:flutter/material.dart';
import 'package:crs_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:crs_app/pages/admin_home_page.dart';
import 'package:crs_app/pages/signup_page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(

                ),
                labelText: 'Username',
              ),
              controller: usernameController,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(

                ),
                labelText: 'Password',
              ),
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicWidth(
              stepWidth: double.infinity,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Login'),
                ),
                onPressed: () async{
                  final response = await userProvider.login(
                    usernameController.text,
                    passwordController.text,
                  );
                  if(response != null){
                    usernameController.text = '';
                    passwordController.text = '';
                    Navigator.pushReplacementNamed(context,
                        HomePage.routeName
                    );
                  }
                },
              ),
            ),
            TextButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue[700],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
