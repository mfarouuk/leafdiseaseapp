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
  bool nameEditable = false;
  bool emailEditable = false;
  bool pwdEditable = false;


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
        'password': pwdController.text.trim(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFieldContainer(
                'Name',
                nameController,
                nameEditable,
                    () {
                  setState(() => nameEditable = !nameEditable);
                },
              ),
              _buildFieldContainer(
                'Email',
                emailController,
                emailEditable,
                    () {
                  setState(() => emailEditable = false);
                },
              ),
              _buildFieldContainer(
                'Password',
                pwdController,
                pwdEditable,
                    () {
                  setState(() => pwdEditable = !pwdEditable);
                },
              ),
          SizedBox(height: 16),
          Container(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.lightBlue.shade900),
              onPressed: () => showConfirmationDialog(context),
              child: Text('Save Changes'),
            ),

          ),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () => showCancelationDialog(context),
                  child: Text('Cancel Changes'),
                ),

              )

            ],

          ),

        ),

      ),
    );
  }

  Widget _buildFieldContainer(String label, TextEditingController controller, bool editable, Function() onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: label == 'Password',
              enabled: editable,
              decoration: InputDecoration(
                hintText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: editable ? Icon(Icons.save) : Icon(Icons.edit),
          ),
        ],
      ),
    );


  }
}
