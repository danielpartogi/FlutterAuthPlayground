import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType{
    login,
    register
}

bool _loading = false;


class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  BuildContext _ctx;
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validate(){
    final form = formKey.currentState;
    if(form.validate()){
      form.validate();
    form.save();
    return true;
    }
    return false;
  }

  void submit() async {
    if (validate()){
     try {
    if (this._formType == FormType.login) {
      
      setState(() {
       _loading = true; 
      });
         FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password
      );
      print('Signed In ${user.uid}');
      Navigator.of(_ctx).pushReplacementNamed("/home");
       setState(() {
       _loading = false; 
      });
    } else {
       setState(() {
       _loading = true; 
      });
      FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password
      );
      print('Register User: ${user.uid}');
      setState(() {
       _formType = FormType.login; 
       _loading = false;
      });
      formKey.currentState.reset();
    }
     } catch (err) {
       print('Error $err');
     }
    }
  }

  void register(){
    formKey.currentState.reset();
    setState(() {
      this._formType = FormType.register;
    });
  }

    void login(){
       formKey.currentState.reset();
    setState(() {
      this._formType = FormType.login;
    });
  }

  Widget _buildWidget() {
    return new Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Email'
                ),
                validator: (value) => value.isEmpty ? 'Email can\'t empty' : null,
                onSaved: (value) => _email = value,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'PASSWORD',
                ),
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Password can\'t empty' : null,
                onSaved: (value) => _password = value,
              ),
              new RaisedButton(
                child: new Text(
                    _formType == FormType.login?'Login' :
                      'Register', 
                    style: new TextStyle(fontSize: 30.0)),
                onPressed: submit,
              ),
              new FlatButton(
                child: new Text(
                    _formType ==FormType.login?'Create New Account' :
                    'Have an account? Login',
                    style: TextStyle(
                    fontSize: 20.0
                  ),
                  ),
                onPressed: _formType ==FormType.login? register:login,
              )
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      appBar: new AppBar(
        title: new Text('login'),
      ),
      body: ModalProgressHUD(child: _buildWidget(), inAsyncCall: _loading),
    );
  }


}