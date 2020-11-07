import 'package:auto_mate_app1/screens/authenticate/authenticate.dart';
import 'package:auto_mate_app1/screens/home/home.dart';
import 'package:auto_mate_app1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrappper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);
    print(user);

    //return either home or authenticate widget
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
    
  }
}