import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mashcafe/models/mash.dart';
import 'package:mashcafe/screens/home/settings_form.dart';
import 'package:mashcafe/services/auth.dart';
import 'package:mashcafe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mashcafe/screens/home/mash_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mback.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }



    return StreamProvider<List<Mash>>.value(
      value: DatabaseService().mash,
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('Mash Cafe'),
          backgroundColor: Colors.brown,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                   await _auth.signingOut();
              },
                label: Text(
                    'Exit',
                     style: TextStyle(color: Colors.white),
                ),
              icon:Icon(
                  Icons.exit_to_app,
                  color: Colors.amber,
              )
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(
                    Icons.settings,
                    color: Colors.amber,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                 image: AssetImage('assets/mback.png'),
                 fit:BoxFit.cover,
              ),
            ),
            child: MashList()
        ),



      ),
    );
  }
}
