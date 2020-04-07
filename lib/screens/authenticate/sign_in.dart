import 'package:flutter/material.dart';
import 'package:mashcafe/services/auth.dart';
import 'package:mashcafe/shared/constants.dart';
import 'package:mashcafe/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth =  AuthService();
  final _formKey= GlobalKey<FormState>();
  bool loading=false;

  // text field state
  String email="",password="",error="";



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text('Sign In To Mash Cafe'),
        actions: <Widget>[
          FlatButton.icon(
            color: Colors.amber,
            label: Text('Register'),
            icon: Icon(Icons.person),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mback.png'),
            fit: BoxFit.cover,
          )
        ),
        padding: EdgeInsets.symmetric(vertical:20.0 ,horizontal:50.0),
        child: Form(
            key: _formKey,
            child:Column(
              children: <Widget>[
                 SizedBox(height: 20.0),
                 TextFormField(
                   decoration: textInputDecoration.copyWith(hintText:'E-mail'),
                   validator: (val) => val.isEmpty ? 'Enter email !!!!' : null ,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter password of more than 5 characters !!!!' : null ,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.amber,
                child: Text(
                  'Sign In',
                    style:TextStyle(
                      color: Colors.white
                    )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result= await _auth.signingInWithEmailandPassword(email,password);
                       if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'colud not sign in with those credentials';
                      });
                    }
                  }
                }
              ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(
                    color:Colors.red,
                    fontSize: 14.0,
                  ),
                ),
            ],
          )
        )
      ),
    );
  }
}

