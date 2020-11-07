import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Insurance extends StatefulWidget {
  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {

  String _telephone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Insurance Call'),
        centerTitle: true,
      ),
      body:Column(
        children: [

          SizedBox(height: 50.0),
          TextFormField(
  decoration: const InputDecoration(
    icon: Icon(Icons.person),
    hintText: 'Enter the Insurance Phone Number',
    labelText: 'Insurance Phone Number',
  ),
  onSaved: (String value) {
   _telephone=value;
  },
  
),
  RaisedButton(
    child: Text('Save'),
    onPressed: (){
      _onPressed();
    },
  ),
    SizedBox(height: 50.0),
    new SizedBox(
      
      width: double.infinity,
    child:IconButton(
      icon: Icon(Icons.phone,),
      
      onPressed: ()async{
        
        String url = 'tel://$_telephone';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
      },
    ),)
        ],
      )
 
    );}

    void _onPressed() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("users").document(firebaseUser.uid).updateData(
  {
    'insurance':_telephone,
  });
    
  }
}

