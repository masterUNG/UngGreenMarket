import 'package:flutter/material.dart';
import 'package:greenmarket/screens/home.dart';
import 'package:greenmarket/screens/singin.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'green market',
      home: SignIn(),
    );
  }
}
