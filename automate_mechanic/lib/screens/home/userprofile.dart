
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/models/user.dart';
import 'package:mechanic_app/screens/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _formKey = GlobalKey<FormState>();

  String _userId;
  String _downloadUrl;

  //from values
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

    return StreamBuilder<Object>(
        stream: DatabaseServices(uid: user.uid).mechanicDataModel,
        builder: (context, snapshot) {
          MechanicData mechanicData=snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            
            children: <Widget>[
              
              _downloadUrl==null ? Image.network(
                "https://firebasestorage.googleapis.com/v0/b/automate-aa7d5.appspot.com/o/images%2Fporfile%20image.png?alt=media&token=31769df6-ec16-4df4-92c4-6dd236361ba0",
                height: 200.0,
              ): Image.network(_downloadUrl,
                height: 200.0,
                width: 200.0,
              ),
             // Image(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/automate-aa7d5.appspot.com/o/images%2Fporfile%20image.png?alt=media&token=31769df6-ec16-4df4-92c4-6dd236361ba0"),),
              SizedBox(height: 10.0,),
              //name
              Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.person, color: Colors.black),
                   ),
                  title: Text(
                    'Name',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(mechanicData.name, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)
              ),
               
                //vehicle type
              Card(elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.insert_comment, color: Colors.black),
                   ),
                  title: Text(
                    'Bio',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(mechanicData.bio, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)),
               
                Card(elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.phone, color: Colors.black),
                   ),
                  title: Text(
                    'telephone number',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(mechanicData.telephone, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)),

                Card(elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.location_on, color: Colors.black),
                   ),
                  title: Text(
                    'Address',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  subtitle: Row(
                   children: <Widget>[
                       //Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(mechanicData.address, style: TextStyle(color: Colors.black,fontSize: 20.0))
                  ],
        ),
                ),)),
                
                Card(elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                child:Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child:ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                     leading: Container(
                     padding: EdgeInsets.only(right: 12.0),
                     decoration: new BoxDecoration(
                     border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                    child: Icon(Icons.rate_review, color: Colors.black),
                   ),
                  title: Text(
                    'Rating',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  
                  
                ),)),
        
                
           
            ],
          ),
        );
      }
    );
  }
}