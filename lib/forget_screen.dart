import 'package:Treet/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Treet/guest/guest_home_screen.dart';
import 'package:Treet/home_screen.dart';
import 'package:Treet/signup_screen.dart';

class Forgetpassword extends StatefulWidget {
  @override
  _Forgetpassword createState() => _Forgetpassword();
}

class _Forgetpassword extends State<Forgetpassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Forget Password', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },onChanged: (String Value) {
                      print(Value);
                    },
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),


                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      color: Colors.lightBlue.shade900,
                      child: MaterialButton(
                        onPressed: () {

              if (_formKey.currentState!.validate()) {
                FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),

                  );
                  setState(() {
                    emailController.clear();
                  });
                }).catchError((error) {});
              }
                        },
                        child: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signUp()),
                            );
                          },
                          child: Text("Register"),
                        ),
                      ],
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
