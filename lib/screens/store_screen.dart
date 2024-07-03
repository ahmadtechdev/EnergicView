// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:energicview/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import '../button.dart';
import '../colors.dart';
import 'navbar.dart';
import 'relay_control.dart';
import 'signup_screen.dart';
import 'educational_content.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title: Text(
          "Store Products", style: TextStyle(color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        foregroundColor: wColor,
        toolbarHeight: MediaQuery.of(context).size.height / 10, // Set your desired height here
      ),
      body: SingleChildScrollView(

        child: Container(
          color: pColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Arduino',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'The price varies based on the specific model and version. Generally, Arduino Uno costs around Rs 3500 to Rs 4500, ',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Why We Use It: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Arduino is a popular open-source microcontroller platform based on easy-to-use hardware and software. It is widely used for prototyping and DIY electronics projects due to its simplicity, versatility, and large community support. It is great for beginners and advanced users alike to create various electronic projects, from simple LED blinking to complex robotic systems.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                    'assets/images/simg1.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'ESP32',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                 'The price of an ESP32 module typically ranges from Rs 1500 to 2500, depending on the brand, features, and quantity purchased.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Why We Use It:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'The ESP32 is a powerful Wi-Fi and Bluetooth-enabled microcontroller widely used in IoT (Internet of Things) projects. It offers a rich set of features including ample processing power, built-in Wi-Fi and Bluetooth connectivity, low power consumption, and a variety of GPIO pins, making it suitable for a wide range of IoT applications such as home automation, sensor networks, and wearable devices.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                    'assets/images/simg2.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'ACS712 Current Sensor',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                 'The price of an ACS712 current sensor varies depending on the current rating and whether it is a module or standalone component. Generally, prices range from Rs 500 to Rs 600',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Why We Use It:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'The ACS712 is a Hall effect-based linear current sensor that provides an analog voltage output proportional to the AC or DC current passing through the device. It is commonly used in projects where monitoring and measuring current is required, such as in power monitoring systems, battery chargers, motor control, and energy management applications.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                    'assets/images/simg3.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Relays',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                 'A relay is an electrically operated switch. It uses a small control current to switch a larger circuit on or off. These come in various channel configurations, letting you control multiple circuits with a single control signal. ',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Why it's used:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Relays are beneficial for controlling high-power devices like motors, lights, and appliances with a low-power control signal from a microcontroller',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                    'assets/images/simg4.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Jumper Wires',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                 'Jumper wires are pre-crimped wires with male or female connectors on each end. They are used for temporary or permanent connections on breadboards or PCBs.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Why it's used:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Jumper wires make it easy to prototype circuits without soldering. They come in various lengths and colors for easy identification and organization.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                    'assets/images/simg6.png'),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
