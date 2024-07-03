import 'package:flutter/material.dart';

import '../colors.dart';
import 'navbar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title: const Text(
          "About Us",
          style: TextStyle(
              color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        foregroundColor: wColor,
        toolbarHeight: MediaQuery.of(context).size.height /
            14, // Set your desired height here
      ),
      body: SingleChildScrollView(
        child: Container(
          color: pColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/numl.png',
                ), // Replace with your LED Bulb image

                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'Created By',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'Ahmad Raza Ali',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'Shumaim Saleem',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'Supervised By:',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: yColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'Mr Naeem Raza',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'The aim of EnergicView is to provide an integrated solution for remote appliance control, energy consumption monitoring, and cross-platform accessibility. EnergiView aims to enhance energy efficiency, convenience, and user engagement in managing household or commercial electrical systems.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
