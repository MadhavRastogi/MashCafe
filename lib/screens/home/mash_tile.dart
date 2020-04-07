import 'package:flutter/material.dart';
import 'package:mashcafe/models/mash.dart';

class MashTile extends StatelessWidget {

  final Mash mash;
  MashTile({this.mash});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0,10.0,20.0,0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/cup.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[mash.strength],
          ),
          title: Text(mash.name),
          subtitle: Text("Takes ${mash.sugars} cube(s) of sugar"),
        ),
      ),
    );
  }
}
