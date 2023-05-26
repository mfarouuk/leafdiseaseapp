import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:Treet/home_screen.dart';
import 'package:Treet/login_screen.dart';
import 'package:Treet/signup_screen.dart';
import 'package:Treet/manageAccount_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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


