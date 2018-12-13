import 'package:flutter/material.dart';
import 'Login.dart';
import 'Home.dart';
import 'Auth.dart';

class Root extends StatefulWidget{

  Root({this.auth});
  final BaseAuth auth;

  State<StatefulWidget> createState()=>new _RootState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootState extends State<Root>{

  AuthStatus _authStatus=AuthStatus.notSignedIn;

  void initState(){
    super.initState();
    widget.auth.currentUser().then((userId){
      setState((){
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      _authStatus=AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      _authStatus=AuthStatus.notSignedIn;
    });
  }

  Widget build(BuildContext context){
    switch(_authStatus){
      case AuthStatus.notSignedIn:{
        return new Login(auth: widget.auth, onSignedIn: _signedIn,);
      }

      case AuthStatus.signedIn:{
        return new Home(auth: widget.auth, onSignedOut: _signedOut,);
      }
    }

  }
}