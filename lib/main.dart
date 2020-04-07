import 'package:flutter/material.dart';
import 'package:mashcafe/models/user.dart';
import 'package:mashcafe/screens/wrapper.dart';
import 'package:mashcafe/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home:Wrapper(),
      ),
    );
  }
}

