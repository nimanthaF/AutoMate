
import 'package:auto_mate_app1/models/user.dart';
import 'package:auto_mate_app1/screens/services/database.dart';
import 'package:auto_mate_app1/screens/shared/constants.dart';
import 'package:auto_mate_app1/screens/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> vehicles = ['BMW', 'TOYOTA', 'NISSAN', 'MITSUBISHI', 'FORD','AUDI','MERCEDEZ'];
  final List<String> ages= ['0','1','2','3','4','5','6'];

  //form values
  String _currentName;
  String _currentVehicle;
  String _currentAge;
  String _insuranceNumber;



  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

   
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userDataModel,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData=snapshot.data;

          if(_currentName==null){
            _currentName='username';
          }

          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your profile',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                initialValue:userData.name ,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),

              SizedBox(height: 8.0),
              //dropdown
             DropdownButtonFormField(
               decoration: textInputDecoration,
               value:  'TOYOTA' ?? userData.vehicleType  /* _currentVehicle*/,
               items: vehicles.map((vehicle){
                 return DropdownMenuItem(
                   value: vehicle,
                   child: Text(vehicle),
                 );
               }).toList(),
                onChanged: (val) => setState(() => _currentVehicle = val),
             ),


             SizedBox(height: 8.0,),
             DropdownButtonFormField(
               decoration: textInputDecoration,
               
              value: '0' ?? userData.age  /*_currentAge*/,
               items: ages.map((age){
                 return DropdownMenuItem(
                   value: age,
                   child: Text(age),
                 );
               }).toList(),
                onChanged: (val) => setState(() => _currentAge = val),
             ),
             
              //slider
              SizedBox(height: 8.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    await DatabaseServices(uid: user.uid).updateUserData(
                      _currentName ?? userData.name ,
                      _currentVehicle ?? userData.vehicleType ,
                      _currentAge ?? userData.age ,
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