
import 'package:auto_mate_app1/screens/home/insurance.dart';
import 'package:auto_mate_app1/screens/home/mechanics/mechanicsprofile.dart';
import 'package:auto_mate_app1/screens/home/mechanics/mehcanics.dart';
import 'package:auto_mate_app1/screens/home/offers.dart';
import 'package:auto_mate_app1/screens/home/show_classified.dart';
import 'package:auto_mate_app1/screens/home/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:auto_mate_app1/screens/services/auth.dart';
import 'package:auto_mate_app1/screens/home/settings_from.dart';
import 'package:auto_mate_app1/models/user.dart';
import 'fuel.dart';


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
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Mate"),
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
               _showSettingdPanel();
              },
            )
        ],
      ),
      body:Card(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: UserProfile(),

            )
          ],
        ),
        color: Colors.lime[400],
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
        leading: Icon(Icons.assignment),
        title: Text('classifieds'),
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>ShowClassifieds()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.build_circle_rounded),
        title: Text('mechanics'),
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>Map()),
          );
        }
      ),
      ListTile(
        leading: Icon(Icons.breakfast_dining),
        title: Text('Insurance'),
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>Insurance()),
          );
        }
      ),
       ListTile(
        leading: Icon(Icons.business_center_sharp),
        title: Text('Offers & deals'),
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>ShowOffer()),
          );
        }
      ),
      ListTile(
        leading: Icon(Icons.business_center_sharp),
        title: Text('Fuel & Gas'),
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>Fuel()),
          );
        }
      ),
    ],
  ),
),
       
  );
  }
}