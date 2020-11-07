import 'package:auto_mate_app1/models/classified.dart';
import 'package:auto_mate_app1/screens/home/imagecap.dart';
import 'package:auto_mate_app1/screens/home/show_classified.dart';
import 'package:auto_mate_app1/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:auto_mate_app1/screens/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddClassified extends StatefulWidget {
  @override
  _AddClassifiedState createState() => _AddClassifiedState();
}

class _AddClassifiedState extends State<AddClassified> {

  final Firestore fb = Firestore.instance;

  final databaseReference = Firestore.instance;

  final List<String> vehicles = ['BMW', 'TOYOTA', 'NISSAN', 'MITSUBISHI', 'FORD','AUDI','MERCEDEZ'];
 // final List<String> BMWmodel=['116i','118d','118d','118i','120d','120i','123d','130i','125i','135i','218d'];
 // final List<String> TOYOTAmodel=['4Runner','Alex','Allion','Alphard','Altezza'];
  final List<String> mileages= ['1,000<','1,000-5,000','5,000-10,000','10,000,-15,000','15,000>'];
  final List<String> age= ['new','used','reconditioned'];
  
 // List<String> models=[];
  

  String _vehicelType;
  String _model;
  String _description;
  String _usageDistance;
  String _ageType;
  String _downloadUrl;
  String _userId;
  String _telephone;

  String initialModelValue='Model';

  final vehicleTypeController=TextEditingController();
  final descriptionController=TextEditingController();
  final usageDistanceController=TextEditingController();

  Future downloadImage()async{
    StorageReference _reference=FirebaseStorage.instance.ref().child("images/$_userId.png");
    String downloadAddress=await _reference.getDownloadURL();
    setState(() {
      _downloadUrl=downloadAddress;
    });
  }

  

  @override
  Widget build(BuildContext context) {

    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });

    downloadImage();
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Add classifieds"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Column(
        children: <Widget>[

          Text('select the vehicle brand'),
          
        DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _vehicelType ?? vehicles[0],
            items: vehicles.map((vehicle){
              return DropdownMenuItem(
                value: vehicle,
                child: Text(vehicle),
              );
            }).toList(),
            onChanged: (val)=> setState(()=> _vehicelType=val),
          ),

        

           SizedBox(height: 10.0,),

          Text('Enter the mileage'),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _usageDistance ?? mileages[0],
            items: mileages.map((mileage){
              return DropdownMenuItem(
                value: mileage,
                child: Text(mileage),
              );
            }).toList(),
            onChanged: (val)=>setState(()=> _usageDistance=val),
          ),
          SizedBox(height: 10.0,),
          
          

          SizedBox(height: 10.0,),

          Text('add your descrpition'),
          TextFormField(
            maxLines: 4,
            minLines: 2,
            decoration:textInputDecoration,
            validator: (val)=>val.isEmpty ? 'Please enter the description':null,
            onChanged: (val) => setState(() => _description = val),
          ),
          SizedBox(height: 20.0,),

          Text('conatact  number'),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val)=>val.isEmpty? 'Please enter your contact number':null,
            onChanged: (val)=>setState(()=>_telephone=val),
          ),
          
          ImageCap(),

          /*
          RaisedButton(
            child: Text('image capture'),
            onPressed: (){
              Navigator.push(
                context, 
               MaterialPageRoute(builder: (context)=>ImageCapture()),
                );
            },
          ),
          */
        
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'submit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()async{
             _createRecord();
             Navigator.push(context, 
             MaterialPageRoute(builder: (context)=>ShowClassifieds()),
             );
            },
          )

        ],
      ),

    ));
  }

  void _createRecord() async{
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  databaseReference.collection("classifieds").document(firebaseUser.uid).setData(
  {
    'vehicle type': _vehicelType,
      'usage distance':_usageDistance,
      'description':_description,
    'image':_downloadUrl,
  });
}

  

 
}

