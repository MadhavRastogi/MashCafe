import 'package:flutter/material.dart';
import 'package:mashcafe/models/user.dart';
import 'package:mashcafe/services/database.dart';
import 'package:mashcafe/shared/constants.dart';
import 'package:mashcafe/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formKey = GlobalKey<FormState>();
  final List<String> sugars =['0','1','2','3','4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key:_formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Mash Cafe profile',
                  style: TextStyle(fontSize: 18.0,color:Colors.brown[700]),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: textInputDecoration.copyWith(fillColor:Colors.brown,enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber[400] , width: 2.0)
                  ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter your name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                  cursorColor: Colors.amber[400],
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  onChanged: (val) => setState(() => _currentSugars = val),
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text(
                        '$sugar cubes of sugar',
                        style: TextStyle(color:Colors.brown[800]),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                //slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions:8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),

                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.brown,
                  child: Text(
                      'Update',
                      style:TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName  ?? userData.name,
                          _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );

        }
        else {
          return Loading();
        }
      }
    );
  }
}
