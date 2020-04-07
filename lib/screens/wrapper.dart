import 'package:flutter/material.dart';
import 'package:mashcafe/models/user.dart';
import 'package:mashcafe/screens/authenticate/authenticate.dart';
import 'package:mashcafe/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    // return either home or authenticate widget
    if (user == null)
    return Authenticate();
    else
    return Home();

  }
}
