
import 'package:auto_mate_app1/screens/home/mechanics/direction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';



class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
  
}

class _MapState extends State<Map> {

bool mapToggle=false;
var currentLocation;
var clients=[];
var fiterdist;
GoogleMapController mapController;
Set<Marker> marker = {};

String _userID;
String _name;
String _bio;
String _telephone;
Position position;

String _currentUser;
  
 void initState(){
super.initState();
Geolocator().getCurrentPosition().then((currloc){
setState(() {
  currentLocation=currloc;
  print(currentLocation.latitude);
  print(currentLocation.longitude);

  mapToggle=true;
  populateClients();
});

});

}

  populateClients(){
clients=[];
Firestore.instance.collection('mechanics location').getDocuments().then((docs)
{
if(docs.documents.isNotEmpty){
for(int i=0;i<docs.documents.length;++i){
clients.add(docs.documents[i].data);
String c= i.toString();
initMarker(docs.documents[i].data,c);

}
  
}
});
}




 initMarker(clients,String i){
   
   
   this.setState((){
marker.add(Marker(
  markerId: MarkerId(i),
  position: LatLng(clients['location'].latitude,clients['location'].longitude),
  draggable: false,
  infoWindow: InfoWindow(
    title: clients['name'],
    snippet: clients['bio'],
    onTap: (){
      _userID=clients['uid'];
      _onPressed();
      _showSettingdPanel();
    }
  ),
  
));
   });
   

 }  

filterMarkers(dist){
marker.clear();

  for(int i=0;i<clients.length;i++){
Geolocator().distanceBetween(currentLocation.latitude, currentLocation.longitude, clients[i]['location'].latitude, clients[i]['location'].longitude).then((calDist){
if(calDist/1000<double.parse(dist)){
  String c=i.toString();
  placeFilteredMarker(clients[i],calDist/1000,c);
}
});
  }
}

placeFilteredMarker(client,distance,c){

 //this.setState((){
marker.add(Marker(
  markerId: MarkerId(c),
  position: LatLng(client['location'].latitude,client['location'].longitude),
  draggable: false,
  
  
));
 //  });

}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
     appBar: AppBar(
         title: Text('Map'),
         backgroundColor: Colors.green[500],
         actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list),
           onPressed: getDist
          )

        ],
       
      ),
     body:Column(
       children: <Widget>[
Stack(
children: <Widget>[

  Container(
height:MediaQuery.of(context).size.height-80.0,
width: double.infinity,
child: mapToggle?
GoogleMap(
onMapCreated: onMapCreated,
 initialCameraPosition:CameraPosition(
   target: LatLng(currentLocation.latitude,currentLocation.longitude),
   zoom: 10.0) ,
     mapType: MapType.normal,
     myLocationEnabled:true ,
    markers: marker,

):
Center(child: 
Text("Loading..Please wait",style: TextStyle(
fontSize: 20.0

),)
)
  )
]

,)

       ],
     ) ,
     
    );
    
  }
void onMapCreated(controller){
  setState(() {
    mapController=controller;
    
  });
}
  Future<bool>getDist(){
    return showDialog(context: context,
    barrierDismissible: true,
    builder: (context){
      return AlertDialog(
title: Text('Enter distance'),
contentPadding: EdgeInsets.all(10.0),
content: TextField(decoration: InputDecoration(hintText: 'enter distance'),
onChanged: (val){
setState(() {
  fiterdist=val;
});

},


),
actions: <Widget>[
  FlatButton(child: Text('ok'),
  color: Colors.transparent,
  textColor: Colors.blue,
  onPressed: (){

    filterMarkers(fiterdist);
    Navigator.of(context).pop();
  },
  )
],
      );
    }
    );
  }

  void _showSettingdPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.account_circle),
               title: Text(_name), 
              ),
              new ListTile(
               leading: Icon(Icons.assignment),
               title: Text(_bio), 
              ),
              new ListTile(
                leading: Icon(Icons.phone),
                title: Text(_telephone),
              ),
              RaisedButton(
                child: Text('Share Location'),
                onPressed: (){
                  getCurrentLocation();
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>MapView()),
          );
                },
              ),
            ],
          ),
        );
      });
    }

    void _onPressed() async{
    //var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("Mechanics").document(_userID).get().then((value){
      _name=value.data['name'];
      _bio=value.data['bio'];
      _telephone=value.data['telephone'];
    });
    var firebaseUser = await FirebaseAuth.instance.currentUser();
 Firestore.instance.collection("users").document(firebaseUser.uid).get().then((value){
      _currentUser=value.data['name'];
    });
  }

  void getCurrentLocation()async{
    Position res=await Geolocator().getCurrentPosition();
    setState(() {
      position=res;
    });

    
  
  Firestore.instance.collection("mechanics location").document(_userID).updateData(
  {
    'user location':GeoPoint(position.latitude,position.longitude),
    'user name': _currentUser,
  });
  
  }

 
}

