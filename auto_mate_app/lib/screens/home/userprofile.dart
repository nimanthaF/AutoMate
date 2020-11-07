import 'package:auto_mate_app1/models/user.dart';
import 'package:auto_mate_app1/screens/services/database.dart';
import 'package:auto_mate_app1/screens/shared/constants.dart';
import 'package:auto_mate_app1/screens/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _formKey = GlobalKey<FormState>();

  //from values
  String _currentName;
  String _currentVehicle;
  String _currentAge;

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

    return StreamBuilder<Object>(
        stream: DatabaseServices(uid: user.uid).userDataModel,
        builder: (context, snapshot) {
          UserData userData=snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),

              Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.person, color: Colors.black),
                   ),
                  title: Text(
                    'Name',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(userData.name, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)
              ),
              Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.person, color: Colors.black),
                   ),
                  title: Text(
                    'Vehicle',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(userData.vehicleType, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)
              ),
              Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.person, color: Colors.black),
                   ),
                  title: Text(
                    'How long have you been driving',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(userData.age, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)
              ),
              //name
             
           
            ],
          ),
        );
      }
    );
  }
}