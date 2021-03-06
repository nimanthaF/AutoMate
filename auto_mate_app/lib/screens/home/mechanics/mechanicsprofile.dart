import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mechanics profile"),
        centerTitle: true,
      ),
      body: starRating(),
    );
  }


  Widget starRating(){
    var rating = 3.0;
    return Container(
      child: Center(
        child: SmoothStarRating(
          rating: rating,
          isReadOnly: false,
          size: 80,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 5,
          allowHalfRating: true,
          spacing: 2.0,
          onRated: (value) {
            print("rating value -> $value");
            // print("rating value dd -> ${value.truncate()}");
          },
        )),
    );
  }  
}