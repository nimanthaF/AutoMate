import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic_app/screens/home/direction.dart';



class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  final firestoreInstance = Firestore.instance;

  var mechData = Firestore.instance.collection("mechanics location").document("uid").get();
   
  String _userId;
  String _name;
  String _bio;
  String _telephone;
  Position  _userLocation;
  String _userName;
  

  GoogleMapController _controller;
  Position position;
  Widget _child;

  final databaseReference = Firestore.instance;

  QuerySnapshot querySnapshot;

 

  @override
  void initState(){
    _child=SpinKitFadingCircle(color: Colors.black,);
    getCurrentLocation();
    super.initState();
    _onPressed();
  }



  void getCurrentLocation()async{
    Position res=await Geolocator().getCurrentPosition();
    setState(() {
      position=res;
      _child=mapWidget();
    });
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  databaseReference.collection("mechanics location").document(firebaseUser.uid).updateData(
  {
    'location':GeoPoint(position.latitude,position.longitude),
    'uid':_userId,
    'name': _name,
    'bio':_bio,
    'telephone':_telephone,
  });
  
  }

  

  Set<Marker> _createMarker(){
    
    return <Marker>[
      Marker(
        markerId: MarkerId(_name),
        position:LatLng(position.latitude,position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: _name, snippet: _bio,onTap: (){
          _showSettingdPanel();
           _onPressed();
        }),
      ),
      
      
    ].toSet();

   
  }

  

   
  


  @override
  Widget build(BuildContext context) {
  

    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
 
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: _child,
      

    );
  }

  Widget mapWidget(){
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom:12.0,
      ),
      onMapCreated: (GoogleMapController controller){
        _controller=controller;
      },
      
    );
  
  }


 getMechanicData()async{
   return await Firestore.instance.collection("Mechanics").getDocuments();
 }

 void _onPressed() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("mechanics location").document(firebaseUser.uid).get().then((value){
      _name=value.data['name'];
      _bio=value.data['bio'];
      _telephone=value.data['telephone'];
      _userLocation=value.data['user location'];
      _userName=value.data['user name'];
    });
  }

 

   

  void _showSettingdPanel(){
      showModalBottomSheet(context: context, builder: (context){
        if(_userName==''){
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
              
            ],
          ),
        );}else{
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
              FlatButton(
                child: Text('Get Directions'),
                onPressed: (){
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>MapView()),
          );
                 
                },
              ),
            ],
          ),
        );
        }
      });
    }

  
}

