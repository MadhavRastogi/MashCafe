import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mashcafe/models/mash.dart';
import 'package:mashcafe/screens/home/mash_tile.dart';
import 'package:provider/provider.dart';


class MashList extends StatefulWidget {
  @override
  _MashListState createState() => _MashListState();
}

class _MashListState extends State<MashList> {
  @override
  Widget build(BuildContext context) {

    final mashes = Provider.of<List<Mash>>(context) ?? [];


    return ListView.builder(
        itemCount: mashes.length,
        itemBuilder: (context,index){
           return MashTile(mash: mashes[index]);
        },
    );
  }
}
