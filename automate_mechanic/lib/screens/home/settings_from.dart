
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/models/user.dart';
import 'package:mechanic_app/screens/home/imagecap.dart';
import 'package:mechanic_app/screens/services/database.dart';
import 'package:mechanic_app/screens/shared/constants.dart';
import 'package:mechanic_app/screens/shared/loading.dart';

import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  

  //form values
  String _currentName="username";
  String _currentBio="";
  String _telephone;
  String _address;
  String _downloadUrl;
  String _userId;
  bool _uploaded;


 Future downloadImage()async{
    StorageReference _reference=FirebaseStorage.instance.ref().child("images/$_userId.png");
    String downloadAddress=await _reference.getDownloadURL();
    setState(() {
      _downloadUrl=downloadAddress;
    });
  }
 


  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });

    downloadImage();
    return StreamBuilder<MechanicData>(
      stream: DatabaseServices(uid: user.uid).mechanicDataModel,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          //UserData userData=snapshot.data;
          MechanicData mechanicData=snapshot.data;

          if(_currentName==""){
            _currentName="username";
          }

          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your profile',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Text("user name"),
              TextFormField(
                initialValue:( mechanicData.name ?? _currentName) ,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),

              SizedBox(height: 8.0),
              ImageCap(),
              SizedBox(height: 8.0),
              //dropdown
              Text("bio"),
             TextFormField(
                initialValue:( mechanicData.bio ?? _currentBio) ,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'enter the bio' : null,
                onChanged: (val) => setState(() => _currentBio = val),
              ),
              

             SizedBox(height: 8.0,),
             Text("telephone number"),
             TextFormField(
                initialValue:( mechanicData.telephone ?? _telephone) ,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'enter the telephone number' : null,
                onChanged: (val) => setState(() => _telephone = val),
              ),           

             SizedBox(height: 8.0,), 
             Text("address"),
            TextFormField(
                initialValue:( mechanicData.address ?? _address) ,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'enter the address' : null,
                onChanged: (val) => setState(() => _address = val),
              ), 

             
              //slider
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  
                  if(_formKey.currentState.validate()){
                    await DatabaseServices(uid: user.uid).updateMechanicData(
                      _currentName ?? mechanicData.name,
                      _currentBio ?? mechanicData.bio,
                      _telephone ?? mechanicData.telephone,
                      _address ?? mechanicData.address,
                      mechanicData.rating,
                      _downloadUrl,
                     _userId
                    );
                    Navigator.pop(context);
                  }

                }
              ),
            ],
          ),
        );
        }else{
          return Loading();
        }
        
      }
    );
  }
}