import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leafdisease/about_screen.dart';
import 'package:leafdisease/edit_profile_screen.dart';
import 'package:leafdisease/home_screen.dart';
import 'package:leafdisease/login_screen.dart';
import 'package:leafdisease/view_past_detections_screen.dart';


class guestManageAccount extends StatefulWidget {

  const guestManageAccount({super.key});
  @override
  State<guestManageAccount> createState() => _guestManageAccount();

}


class _guestManageAccount extends State<guestManageAccount> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade900,
            title: Text("Account"),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.all(12),
            physics: BouncingScrollPhysics(),
            children: [
              Container(height: 35,),

              colorTiles(),
            ],
          )
      ),
    );
  }
  Widget colorTiles() {
    return Column(
      children: [
        Card(
          elevation: 4.0, // Add elevation to create a card-like effect
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Adjust margins for spacing
          child: Padding(
            padding: EdgeInsets.all(16.0), // Add padding for content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login or Signup to access your information',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text('Login or Signup'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade300, // Set button background color
                    padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Add rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        colortile(Icons.help, Colors.teal, "About", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => About()),
          );
        }),
        divider(),
      ],
    );
  }


  Widget divider () {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }
  Widget colortile(IconData icon, Color color, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          child: Icon(icon, color: color),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      ),
    );
  }
}
