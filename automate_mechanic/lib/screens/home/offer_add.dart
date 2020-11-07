import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/screens/home/show_offer.dart';
import 'package:mechanic_app/screens/shared/constants.dart';

class OfferAdd extends StatefulWidget {
  @override
  _OfferAddState createState() => _OfferAddState();
}

class _OfferAddState extends State<OfferAdd> {

  String _title;
  String _description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children:<Widget> [
            TextField(
              maxLines: 2,
              decoration: textInputDecoration,
              onChanged: (val)=>setState(()=>_title=val),
            ),

            SizedBox(height:10.0),
            TextField(
              maxLines: 4,
              decoration:textInputDecoration ,
              onChanged: (val) => setState(() => _description = val),
            ),
            SizedBox(height:10.0),
            RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'submit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()async{
             _createRecord();
             Navigator.push(context, 
             MaterialPageRoute(builder: (context)=>ShowOffer()),
             );
            },
          )
          ],
        ),
      ),
    );
  }

  void _createRecord() async{
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  Firestore.instance.collection("offers").document(firebaseUser.uid).setData(
  {
    'title':_title,
    'description':_description
  });
}
}