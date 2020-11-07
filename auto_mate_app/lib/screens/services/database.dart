import 'package:auto_mate_app1/models/classified.dart';
import 'package:auto_mate_app1/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  // collection refernces
  final CollectionReference autoMateCollection= Firestore.instance.collection("users");
  final CollectionReference autoMateClassified=Firestore.instance.collection("classifieds");

  Future updateUserData(String name,String vehicleType, String age)async{
    return await autoMateCollection.document(uid).setData({
      'name': name,
      'vehicle type': vehicleType,
      'age' : age,
      
    });
  }

  //add classifieds
  Future addClassifieds(String vehicleType,String usageDistance,String description) async{
    return await autoMateClassified.document(uid).setData({
      'vehicle type': vehicleType,
      'usage distance':usageDistance,
      'description': description,
    });
  }

  //user data list from snapshots
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserData(
        name: doc.data['name'] ?? '',
        vehicleType: doc.data['vehicle type'] ?? '',
        age: doc.data['age'] ?? '',
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name:snapshot.data['name'],
      vehicleType: snapshot.data['vehicle type'],
      age: snapshot.data['age'],
    );
  }

  //classified data from snapshots
  ClassifiedData _classifiedDataFromSnapshots(DocumentSnapshot snapshot){
    return ClassifiedData(
      uid: uid,
      vehicleType: snapshot.data['vehicle type'],
      usageDistance: snapshot.data['usage distance'],
      description: snapshot.data['description']
    );
  }

  //get users stream

  Stream<List<UserData>>get users{
    return autoMateCollection.snapshots().map(_userListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData>get userDataModel{
    return autoMateCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //get classified doc stream
  Stream<ClassifiedData>get classifiedDataModel{
    return autoMateClassified.document(uid).snapshots().map(_classifiedDataFromSnapshots);
  }

}