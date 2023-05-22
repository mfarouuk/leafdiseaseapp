import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:leafdisease/guest/guest_home_screen.dart';
import 'package:leafdisease/home_screen.dart';
import 'package:leafdisease/signup_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    Text('Login', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
                    TextFormField(
                      controller: pwdController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      onChanged: (String Value) {
                        print(Value);
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure ? Icons.remove_red_eye : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      color: Colors.lightBlue.shade900,
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: pwdController.text,
                            ).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => homeScreen()),
                              );
                            }).catchError((error) {});
                          }
                        },
                        child: Text(
                          'Login',
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
                    Center(child: Text('Or',style: TextStyle(fontSize: 18),)),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      color: Colors.teal,
                      child: MaterialButton(
                        onPressed: () {
                          FirebaseAuth.instance.signInAnonymously().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => guesthomeScreen()),
                            );
                          }).catchError((error) {});
                        },
                        child: Row( // Add a Row to contain the icon and text
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.white), // Add the desired icon
                            SizedBox(width: 8.0), // Add some spacing between the icon and text
                            Text(
                              'Continue as a Guest',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
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
