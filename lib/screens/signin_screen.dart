// ignore_for_file: prefer_const_constructors

import 'package:energicview/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../button.dart';
import '../colors.dart';
import 'signup_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title: const Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold),),
        foregroundColor: wColor,
        // actions: [Icon(Icons.more_vert)],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: pColor,
        ),
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  child:  Image.asset(
                    'assets/images/logo.png',
                    scale: 1,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: loginEmailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: p1Color,
                            filled: true,
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor: wColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // enabledBorder: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: wColor, fontWeight: FontWeight.w700),

                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Please enter a valid Email address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: loginPasswordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          cursorColor: wColor,
                          decoration: InputDecoration(
                            fillColor: p1Color,
                            filled: true,
                            prefixIcon: Icon(Icons.lock_outline),
                            prefixIconColor: wColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: wColor, fontWeight: FontWeight.w700),

                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a password ";
                            }
                            return null;
                          },
                        ),


                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )),
                RoundButton(
                  title: "Sign in",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var loginEmail = loginEmailController.text.trim();
                      var loginPassword = loginPasswordController.text.trim();
                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: loginEmail, password: loginPassword))
                            .user;

                        if (firebaseUser != null) {
                          Get.to(() => HomeScreen());
                        } else {
                          print("CHeck Email & password");
                        }
                      } on FirebaseAuthException catch (e) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Check email & password"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            margin: EdgeInsets.only(
                                bottom: 12, right: 20, left: 20),
                          ),
                        );
                        print("Error: $e");
                      }
                    }
                  }
                  ,
                ),

                SizedBox(
                  height: 70.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: wColor),),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Card(
                          color: pColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("SignUp",
                                style: TextStyle(
                                    color: yColor, fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
