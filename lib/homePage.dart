import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _signOut,
              child: new Text('Sign Out'),
            )
          ],
        ),
      )
    );
  }

   void _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }
}