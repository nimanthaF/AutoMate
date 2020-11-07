import 'package:auto_mate_app1/screens/services/auth.dart';
import 'package:auto_mate_app1/screens/shared/constants.dart';
import 'package:auto_mate_app1/screens/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading=false;


  //text sate
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to AutoMate"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E mail'),
                validator: (val)=> val.isEmpty ? 'Enter an email': null,
                onChanged: (val){
                  setState(()=> email=val );
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length < 6 ? 'password isnt strong enough': null,
                obscureText: true,
                onChanged: (val){
                  setState(()=> password=val );
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text("Sign in"),
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() =>loading=true);
                    dynamic result=await _auth.signInWithEmailPassword(email, password);
                   if(result==null){
                      setState(()
                       {
                        error='could not sign in with those credentials';
                        loading=false;
                        });
                    }
                  } 
                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}