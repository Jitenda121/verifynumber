import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/function.dart';
import 'package:flutter_application_1/loginwithphone.dart';
import 'package:flutter_application_1/realtimea.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:flutter_application_1/verifycode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:ui';

class itachi extends StatefulWidget {
  const itachi({super.key});

  @override
  State<itachi> createState() => _itachiState();
}

class _itachiState extends State<itachi> {
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _hasError = false;
  bool get hasError => _hasError;
  String? _errorCode;
  String? get errorCode => _errorCode;
  String? _name;
  String? get name => _name;
  String? _email1;
  String? get email1 => _email1;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  String? _uid;
  String? get uid => _uid;
  String? _provider;
  String? get Provider => _provider;
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String email = '';
  String password = '';
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isLogin
                    ? TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(hintText: "User Name"),
                        validator: (value) {
                          if (value.toString().length < 3) {
                            return "username is so small";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            username = value!;
                          });
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(hintText: "Enter email"),
                  validator: (value) {
                    if (!(value.toString().contains('@'))) {
                      return "Invalid email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  key: ValueKey('Password'),
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return "password is so small";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        signup(email, password);
                      }
                    },
                    child: isLogin ? Text("Login") : Text("Sign Up"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text("Don't have an account ? sign up")
                        : Text('Already Signed Up? Login')),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => madara()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)),
                    child: Center(child: Text("Login in with phone")),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => realtime()));
                  },
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black)),
                      child: Center(child: Text("Realtime data base"))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => AuthService().SignInWithGoogle(),
                        child: Image.asset(
                          'assests/download.png',
                          width: 60,
                        ))
                  ],
                ),
                InkWell(
                  onTap: () async {
                    try {
                      if (context.mounted) {
                        final UserCredential userCredential =
                            await signInwithfacebook();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => madara()));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Sign in with Facebook failed: ${e.toString()}"),
                          duration: Duration(minutes: 1),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)),
                    child: Center(child: Text("login with facebook")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInwithfacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
