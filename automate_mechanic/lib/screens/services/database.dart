
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_app/models/user.dart';


class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  // collection refernces
  final CollectionReference autoMateCollection= Firestore.instance.collection("Mechanics");
  

 

   Future updateMechanicData(String name,String bio, String telephone,String address,String rating,String imageUrl,String uid)async{
    return await autoMateCollection.document(uid).setData({
      'name': name,
      'bio': bio,
      'telephone' : telephone,
      'address':address,
      'rating':rating,
      'image':imageUrl,
      'uid':uid,
    });
  }


    //mechanic data list from snapshots
  List<MechanicData> _mechanicListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return MechanicData(
        name: doc.data['name'] ?? '',
        bio: doc.data['bio'] ?? '',
        telephone: doc.data['telephone'] ?? '',
        address: doc.data['address'] ?? '',
        rating: doc.data['rating'] ?? '',
      );
    }).toList();
  }

  //mechanic from snapshot
  MechanicData _mechanicDataFromSnapshot(DocumentSnapshot snapshot){
    return MechanicData(
      uid: uid,
      name:snapshot.data['name'],
      bio: snapshot.data['bio'],
      telephone: snapshot.data['telephone'],
      address:snapshot.data['address'],
      rating:snapshot.data['rating'],
    );
  }


 



  //get mechanic stream
  Stream<List<MechanicData>>get mechanics{
    return autoMateCollection.snapshots().map(_mechanicListFromSnapshot);
  }

  //get user doc stream
  Stream<MechanicData>get mechanicDataModel{
    return autoMateCollection.document(uid).snapshots().map(_mechanicDataFromSnapshot);
  }


  

}