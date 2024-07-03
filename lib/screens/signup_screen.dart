// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../button.dart';
import '../colors.dart';
import '../services/signUpServices.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title:
            const Text("SignUp", style: TextStyle(fontWeight: FontWeight.bold)),
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
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 3,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: p1Color,
                            filled: true,
                            prefixIcon: Icon(Icons.person_2_outlined),
                            prefixIconColor: wColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // enabledBorder: OutlineInputBorder(),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: wColor, fontWeight: FontWeight.w700),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || RegExp(r'[0-9]').hasMatch(value)) {
                              return "Please enter a User Name";
                            } else if (value.length < 3) {
                              return 'Name must be more than 2 character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: p1Color,
                            filled: true,
                            prefixIcon: Icon(Icons.phone),
                            prefixIconColor: wColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // enabledBorder: OutlineInputBorder(),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                                color: wColor, fontWeight: FontWeight.w700),
                          ),
                          validator: (value) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = RegExp(pattern);
                            if (value!.length == 10) {
                              return 'Enter minimum 10 digit mobile number';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: EmailController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
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
                            labelStyle: TextStyle(
                                color: wColor, fontWeight: FontWeight.w700),
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
                          controller: PasswordController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: p1Color,
                            filled: true,
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: wColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: wColor, fontWeight: FontWeight.w700),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a password ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    )),
                RoundButton(
                  title: "Sign Up",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var userName = nameController.text.trim();
                      var userPhone = phoneController.text.trim();
                      var userEmail = EmailController.text.trim();
                      var userPassword = PasswordController.text.trim();

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword)
                          .then((value) => {
                                printInfo(info: "User Created"),
                                signUpUser(
                                  userName,
                                  userPhone,
                                  userEmail,
                                  userPassword,
                                  context
                                )
                              });
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: wColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignInScreen());
                      },
                      child: Card(
                          color: pColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Expanded(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: yColor,
                                      fontWeight: FontWeight.bold)),
                            ),
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
