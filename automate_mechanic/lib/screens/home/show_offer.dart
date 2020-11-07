import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowOffer extends StatefulWidget {
  @override
  _ShowOfferState createState() => _ShowOfferState();
}

class _ShowOfferState extends State<ShowOffer> {



  @override
      void initState() {
        super.initState();
        getOffers().then((results) {
          setState(() {
            querySnapshot = results;
          });
        });
      }

      QuerySnapshot querySnapshot;

      getOffers() async {
        return await Firestore.instance.collection('offers').getDocuments();
      }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
        centerTitle: true,
      ),
      body: _showAds()
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
            //downloadUrl=querySnapshot.documents[i].data['image'];
              
              return Column(
                
                children: <Widget>[
//load data into widgets
                 ListTile(
                   //leading: Image(image: NetworkImage(querySnapshot.documents[i].data['image']),),
                   title: Text(querySnapshot.documents[i].data['title']),
                   subtitle: Text(querySnapshot.documents[i].data['description']),
                   
                 ),
                
                
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

}