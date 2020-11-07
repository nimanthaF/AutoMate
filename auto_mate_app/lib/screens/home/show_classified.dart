import 'package:auto_mate_app1/screens/home/add_classified.dart';
import 'package:auto_mate_app1/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_image/firebase_image.dart';

class ShowClassifieds extends StatefulWidget {
  @override
  _ShowClassifiedsState createState() => _ShowClassifiedsState();
}

class _ShowClassifiedsState extends State<ShowClassifieds> {


  String _vehicelType;
  String _description;
  String _usageDistance;
  String _userId;
  String downloadUrl;

  final databasreferences=Firestore.instance;

 


  @override
      void initState() {
        super.initState();
        getClassifieds().then((results) {
          setState(() {
            querySnapshot = results;
          });
        });
      }

      QuerySnapshot querySnapshot;


  @override
  Widget build(BuildContext context) {

    void _showAddClassifiedPanel(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>AddClassified()),
      );

     
    }
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Classifieds'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add_box),
            label: Text("Add"),
            onPressed: ()=>_showAddClassifiedPanel(),
          ),
          
        ],
      ),
      body: _showAds(),
      
    );

    
  }


  void _showRecords() {
  databasreferences.collection("classifieds").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
      _description=result.data["description"];
      _usageDistance=result.data["usage distance"];
      _vehicelType=result.data["vehicle type"];
    
    });
  });
}

  
  Widget showForm(){
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showButton(),
            Text("vehicle type"),
            Text(_vehicelType),
            Text("mileage"),
            Text(_usageDistance),
            Text("description"),
            Text(_description),
          ],
        ),
      )
    );
  }

  Widget showButton(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
        child: Text('refresh'),
        onPressed: (){
          _showRecords();
        },
        
      ),
      
    );
  }

  Widget _showAds() {
        //check if querysnapshot is null
       
        
        if (querySnapshot != null) {
          return ListView.builder(
            primary: false,
            itemCount: querySnapshot.documents.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, i) {
            downloadUrl=querySnapshot.documents[i].data['image'];
              
              return Column(
                
                children: <Widget>[
//load data into widgets
                 ListTile(
                   leading: Image(image: NetworkImage(querySnapshot.documents[i].data['image']),),
                   title: Text(querySnapshot.documents[i].data['vehicle type']),
                   subtitle: Text(querySnapshot.documents[i].data['description']),
                   
                 ),
                SizedBox(height:10.0),
                
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }

  getClassifieds() async {
        return await Firestore.instance.collection('classifieds').getDocuments();
      }

  



}