class User{

  final String uid;

  User({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String vehicleType;
  final String age;

  UserData({this.uid,this.name,this.age,this.vehicleType});
}

class MechanicData{
  final String uid;
  final String name;
  final String bio;
  final String telephone;
  final String address;
  final String rating;

  MechanicData({this.uid,this.name,this.bio,this.telephone,this.address,this.rating});
}