

import 'package:energicview/screens/about_us.dart';
import 'package:energicview/screens/educational_content.dart';
import 'package:energicview/screens/home_screen.dart';
import 'package:energicview/screens/prediction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../colors.dart';
import 'graphs/area_graph.dart';
import 'graphs/column_graph.dart';
import 'graphs/doughnut_graph.dart';
import 'graphs/spline_graph.dart';
import 'signin_screen.dart';
import 'store_screen.dart';
import 'manual_data_entry_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    String userEmail = "";

    if (user != null) {
      userEmail = user.email ?? "";
    }

    return Drawer(
      backgroundColor: wColor,
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Welcome to EnergicView",
              style: TextStyle(
                  fontSize: 18, color: wColor, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              userEmail,
              style: const TextStyle(
                  fontSize: 16, color: wColor, fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: pColor,
              child: ClipOval(
                child: Image.asset('assets/images/logo.png',),
              ),
            ),
            decoration: const BoxDecoration(
              color: pColor,
            ),
          ),
          ListTile(
            leading: Icon(MdiIcons.home),
            title: const Text(
              'Home',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.hours24),
            title: const Text(
              'Daily Hours',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const YesterdayHoursData());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.sunClock),
            title: const Text(
              'Last Month',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const LastMonth());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.compare),
            title: const Text(
              '2 Month Compare',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const LastTwoMonthCompare());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.calendarMonth),
            title: const Text(
              'Last 6 month',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const PreviousSixMonthData());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.powerPlug),
            title: const Text(
              'Power Trend',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const PredictionScreen());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.bookEducation),
            title: const Text(
              'Learn to Live',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const EducationContentScreen());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.storeCheck),
            title: const Text(
              'Store Products',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const StoreScreen());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.playlistPlus),
            title: const Text(
              'Manual Data Entry',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const ManualDataEntryScreen());
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.information),
            title: const Text(
              'About Us',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const AboutUs());
            },
          ),

          ListTile(
            leading: Icon(MdiIcons.logout),
            title: const Text(
              'Sign out',
              style: TextStyle(
                  fontSize: 17, color: pColor, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => const SignInScreen());
            },
          )
        ],
      ),
    );
  }
}
