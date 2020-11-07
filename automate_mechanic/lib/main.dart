
import 'package:flutter/material.dart';
import 'package:mechanic_app/screens/services/auth.dart';
import 'package:mechanic_app/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:mechanic_app/models/user.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
        title: 'Auto Mate Mechanic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrappper(),
      ),
    );
  }
}
