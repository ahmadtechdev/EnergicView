import 'dart:io';
import 'package:timezone/data/latest.dart' as tz;import 'package:energicview/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCnOqHVsTPE1usH_ZwuaJEZqJ281I8mc8Y',
          appId: '1:63674565821:android:3a2b3c0a71594bd8ff63d4',
          messagingSenderId: '63674565821',
          projectId: 'energicview'))
      : await Firebase.initializeApp();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: pColor),
        useMaterial3: true,
      ),

        home: user != null ? const HomeScreen() : WelcomeScreen(),
    );
  }
}
