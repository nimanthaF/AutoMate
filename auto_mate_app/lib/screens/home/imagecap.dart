import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageCap extends StatefulWidget {


  @override
  _ImageCapState createState() => _ImageCapState();
}

class _ImageCapState extends State<ImageCap> {

  File _imageFile;
  bool _uploaded;
  String _downloadUrl;
  String _userId;

  

  

  Future getImage(bool isCamera)async{
    File image;
    if(isCamera){
      image=await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      image=await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile=image;
    });
  }

  Future uploadImage()async{
    StorageReference _reference=FirebaseStorage.instance.ref().child("images/$_userId.png");
    StorageUploadTask uploadTask=_reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;

    setState(() {
      _uploaded=true;
    });
  }

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

    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Camera"),
            onPressed: (){
              getImage(true);
            },
          ),

          SizedBox(height: 10.0,),
          RaisedButton(
            child: Text("Gallery"),
            onPressed: (){
              getImage(false);
            },
          ),
          _imageFile==null? Container(): Image.file(_imageFile,height: 300.0,width: 300.0,),
          _imageFile==null? Container(): RaisedButton(
            child: Text("upload image"),
            onPressed: (){
              uploadImage();
            },
          ),
          _uploaded==false ? Container() :Text( 'Image Upload'),
          /*RaisedButton(
            child: Text("Download image"),
            onPressed: (){
              downloadImage();
            },
          */
          
          
          _downloadUrl==null ? Container(): Image.network(_downloadUrl),
        ],
      ),
    );
  }
}