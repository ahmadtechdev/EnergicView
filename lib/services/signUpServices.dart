import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/signin_screen.dart';


signUpUser(String userName, String userPhone, String userEmail,
    String userPassword, BuildContext context) async {
  User? userid = FirebaseAuth.instance.currentUser;

   try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'createdAt': DateTime.now(),
      'userId': userid!.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(()=> const SignInScreen()),
    });
  } on FirebaseAuthException catch (e) {

     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: const Text("Check Connection or user already exists"),
         backgroundColor: Colors.red,
         behavior: SnackBarBehavior.floating,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(22),
         ),
         margin: const EdgeInsets.only(
             bottom: 12, right: 20, left: 20),
       ),
     );
    print('Error: $e');
  }
}
