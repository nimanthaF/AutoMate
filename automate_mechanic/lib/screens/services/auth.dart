
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_app/models/user.dart';
import 'package:mechanic_app/screens/services/database.dart';

class AuthService{

  final FirebaseAuth _auth= FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid:user.uid): null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }



  //sign in with email and password
  Future signInWithEmailPassword(String email, String password)async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email and password
  Future registerWithEmailPassword(String email, String password)async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      //create a new document for the user with the uid
      await DatabaseServices(uid: user.uid).updateMechanicData('', '', '','','','','');

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
 
}