

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/screens/home/offer_add.dart';
import 'package:mechanic_app/screens/home/settings_from.dart';
import 'package:mechanic_app/screens/home/show_offer.dart';
import 'package:mechanic_app/screens/home/showsettings.dart';
import 'package:mechanic_app/screens/home/userprofile.dart';
import 'package:mechanic_app/screens/services/auth.dart';
import 'package:mechanic_app/screens/shared/colors.dart';
import 'package:mechanic_app/screens/home/map.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth=AuthService();


  @override
  Widget build(BuildContext context) {

    

    void _showSettingdPanel(){
      showModalBottomSheet(context: context, builder: (context){
        
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Auto Mate Mechanic"),
        actions: <Widget>[/*
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("log out"),
              onPressed: ()async{
                await _auth.signOut();
              }, 
          ), */
          FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed:(){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>ShowSettings()));
              },
            )
        ],
      ),
      body:Card(
        
        child: ListView(
          children: <Widget>[
            UserProfile(),
          ],
        ),
        
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Menu'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Log out'),
        leading: Icon(Icons.person),
        onTap: () async {
          await _auth.signOut();
        },
      ),
      ListTile(
        title: Text('location'),
        leading: Icon(Icons.location_on),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>Map()),
          );
        },
      ),
      ListTile(
        title: Text('Add offers'),
        leading: Icon(Icons.location_on),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>OfferAdd()),
          );
        },
      ),
      ListTile(
        title: Text('Offers'),
        leading: Icon(Icons.location_on),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>ShowOffer()),
          );
        },
      ),
    ],
  ),
),
       
  );
  }
}

