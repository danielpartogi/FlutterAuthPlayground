import 'package:auth/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Login",
      routes: routes,
    );
    
  }
}

Future<bool> checkUserAndNavigate(BuildContext context) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  if(user!=null){
    print(user);
    return true;
  }
  else{
    print('false');
    return false;
  }
} 

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkUserAndNavigate(context).then((res) {
      if (res == true) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}