import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:leafdisease/home_screen.dart';
import 'package:leafdisease/login_screen.dart';
import 'package:leafdisease/signup_screen.dart';
import 'package:leafdisease/manageAccount_screen.dart';

void main() async {

  runApp(MyApp());
  await Firebase.initializeApp();

}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),


  );
  }

}


