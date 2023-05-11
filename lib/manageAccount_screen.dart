import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leafdisease/about_screen.dart';
import 'package:leafdisease/edit_profile_screen.dart';
import 'package:leafdisease/home_screen.dart';
import 'package:leafdisease/login_screen.dart';
import 'package:leafdisease/view_past_detections_screen.dart';


class manageAccount extends StatefulWidget {

  const manageAccount({super.key});
  @override
  State<manageAccount> createState() => _manageAccount();

}


class _manageAccount extends State<manageAccount> {

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
          userTile(),
          divider(),
          colorTiles(),
        ],
      )
      ),
    );
  }
  Widget colorTiles(){
    return Column(
      children: [colortile(Icons.person_outline, Colors.blueAccent.shade400, "Edit Profile",() {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  EditProfileScreen()),
        );

      } ),
        divider(),
        colortile(Icons.history, Colors.green.shade300, "Past Detections", (){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  PastDetection()),
          );

        }),
        divider(),


        colortile(Icons.help, Colors.green.shade300, "About", (){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  About()),
          );

        }),
        divider(),

        colortile(Icons.logout_outlined, Colors.red, "Logout", (){
          print("Clicked");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Login()),
          );

        }),
      ],

    );
    }

  Widget userTile() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final name = userData['name'];
        final email = userData['email'];
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.account_circle_outlined,
              size: 50,
            ),
          ),
          title: Text(
            name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            email ?? '',
          ),
        );
      },
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
