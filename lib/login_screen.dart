import 'package:Treet/forget_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Treet/guest/guest_home_screen.dart';
import 'package:Treet/home_screen.dart';
import 'package:Treet/signup_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  bool isObscure = true;
  String errorMessage = '';

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
                      },
                      onChanged: (String value) {
                        setState(() {
                          errorMessage = '';
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        errorText: errorMessage.isNotEmpty ? errorMessage : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: pwdController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isObscure,
                          onChanged: (String value) {
                            setState(() {
                              errorMessage = '';
                            });
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
                            errorText: errorMessage.isNotEmpty ? errorMessage : null,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Forgetpassword()),
                            );
                          },
                          child: Text("Forgot Password ?", textAlign: TextAlign.right),
                        ),
                      ],
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
                            }).catchError((error) {
                              setState(() {
                                errorMessage = 'Invalid email or password';
                              });
                            });
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
                    Center(child: Text('Or', style: TextStyle(fontSize: 18))),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 8.0),
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

