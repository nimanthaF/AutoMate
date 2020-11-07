
import 'package:flutter/material.dart';
import 'package:mechanic_app/models/user.dart';
import 'package:mechanic_app/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

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