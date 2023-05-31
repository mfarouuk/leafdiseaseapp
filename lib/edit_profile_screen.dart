import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  bool isNameEditable = false;
  bool isEmailEditable = false;
  bool isPasswordEditable = false;


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }
  void showConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ARE YOU SURE YOU WANT TO CONFIRM YOUR CHANGES?',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold

                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.lightBlue.shade900),
                      onPressed: () {
                        _updateUserData();
                        Navigator.pop(
                          context,

                        );
                      },
                      child: Text('YES'),
                    ),
                  ),
                  SizedBox(width: 40,),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        Navigator.pop(
                          context,

                        );
                      },
                      child: Text('NO'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  void showCancelationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ARE YOU SURE YOU WANT TO CANCEL YOUR CHANGES?',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold

                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.lightBlue.shade900),
                      onPressed: () {
                        Navigator.pop(
                          context,

                        );
                      },
                      child: Text('YES'),
                    ),
                  ),
                  SizedBox(width: 40,),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        Navigator.pop(
                          context,

                        );
                      },
                      child: Text('NO'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      nameController.text = doc.get('name');
      emailController.text = doc.get('email');
      pwdController.text = doc.get('password');
    }
  }

  Future<void> _updateUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),


      });

    }
   setState(() {

   });
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.lightBlue.shade900,
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      enabled: isNameEditable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isNameEditable = !isNameEditable;
                      });
                    },
                    icon: Icon(isNameEditable ? Icons.done : Icons.edit),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      enabled: isEmailEditable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                color: Colors.lightBlue.shade900,
                child: MaterialButton(
                  onPressed: () {
                    showConfirmationDialog(context);
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                color: Colors.red,
                child: MaterialButton(
                  onPressed: () {
                    showCancelationDialog(context);
                  },
                  child: Text(
                    'Cancel Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
