// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energicview/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../colors.dart';
import 'package:intl/intl.dart';
import 'navbar.dart';
import 'relay_control.dart';
import 'store_screen.dart';

class EducationContentScreen extends StatefulWidget {
  const EducationContentScreen({super.key});

  @override
  State<EducationContentScreen> createState() => _EducationContentScreenState();
}

class _EducationContentScreenState extends State<EducationContentScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title: Text(
          "Learn to Consume", style: TextStyle(color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        foregroundColor: wColor,
        toolbarHeight: MediaQuery.of(context).size.height / 14, // Set your desired height here
      ),
      body: SingleChildScrollView(

        child: Container(
          color: pColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'LED Light Bulbs',
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
                  'LED bulbs consume significantly less energy than traditional incandescent bulbs while providing the same level of brightness. They have a longer lifespan and are available in various shapes and sizes to fit different fixtures.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
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
                  'PKR 200 to PKR 1000 per bulb depending on wattage and brand.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                child: Image.asset(
                    'assets/images/eimg1.png'), // Replace with your LED Bulb image
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Energy-Efficient Appliances',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Energy-efficient appliances such as refrigerators, air conditioners, washing machines, and fans are designed to consume less electricity without compromising performance. Look for appliances with Energy Star ratings for maximum efficiency.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Varies depending on the appliance type and brand. For example, an energy-efficient refrigerator can range from PKR 30,000 to PKR 100,000.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                child: Image.asset(
                    'assets/images/eimg2.png'), // Replace with your LED Bulb image
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Solar Water Heaters',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Solar water heaters utilize sunlight to heat water for residential and commercial use, reducing the need for electricity or gas-powered water heaters. They are eco-friendly and can significantly lower energy bills.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 50,000 to PKR 200,000 depending on capacity and installation requirements.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                child: Image.asset(
                    'assets/images/eimg3.png'), // Replace with your LED Bulb image
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Smart Power Strips',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Smart power strips automatically shut off power to electronic devices when they are not in use, eliminating standby power consumption. They often come with programmable features and surge protection.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 1000 to PKR 5000 depending on features and brand.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Container(
                child: Image.asset(
                    'assets/images/eimg4.png'), // Replace with your LED Bulb image
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Energy-Efficient Windows',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Energy-efficient windows are designed to minimize heat transfer, keeping interiors cooler in summer and warmer in winter. They typically feature double or triple glazing and low-emissivity coatings.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 5000 to PKR 20,000 per window depending on size and specifications.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Insulation Materials',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Proper insulation in walls, ceilings, and floors helps maintain a consistent indoor temperature, reducing the need for heating and cooling. Materials like fiberglass, cellulose, and foam board insulation are commonly used.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Varies depending on the type and quantity of insulation required.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Energy-Efficient HVAC Systems',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'High-efficiency heating, ventilation, and air conditioning (HVAC) systems use advanced technology to optimize energy usage and provide superior comfort. Look for systems with high SEER (Seasonal Energy Efficiency Ratio) ratings.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 100,000 to PKR 500,000 or more depending on capacity and features.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Motion Sensor Lights',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Motion sensor lights automatically turn on when motion is detected and turn off when the area is vacant, reducing unnecessary energy consumption. They are ideal for outdoor security lighting and indoor spaces like closets and garages.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 1000 to PKR 5000 per fixture depending on features and brand.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Low-Flow Showerheads and Faucets',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Low-flow showerheads and faucets reduce water consumption by limiting flow rates while maintaining adequate water pressure. They help conserve both water and the energy used to heat it.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 500 to PKR 2000 per unit depending on design and brand.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Programmable Thermostats',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Description: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Programmable thermostats allow users to schedule temperature settings based on their daily routines, optimizing energy usage for heating and cooling systems. Some models also offer remote access via smartphone apps.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Price Range: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'PKR 2000 to PKR 10,000 depending on features and brand.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Electricity Slabs Concept in Pakistan',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: yColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Electricity slabs in Pakistan refer to the tiered pricing structure based on the amount of electricity consumed by consumers. Each slab represents a range of consumption, and different tariff rates apply to each slab.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Residential Slabs:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Residential electricity consumers are categorized into different slabs based on their monthly electricity usage. Typically, there are multiple slabs, with the lower slabs representing lower levels of consumption and the upper slabs representing higher levels of consumption.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Lower Slabs:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'These slabs usually encompass lower levels of electricity consumption, such as up to 100 kWh or 200 kWh per month, and have relatively lower tariff rates compared to higher slabs.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Upper Slabs:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Higher slabs represent higher levels of electricity consumption, such as above 200 kWh or 300 kWh per month. Tariff rates for these slabs are higher than those for lower slabs, incentivizing consumers to conserve energy.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Commercial and Industrial Slabs:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Similarly, commercial and industrial electricity consumers are segmented into different slabs based on their electricity usage patterns. Large-scale industries with higher electricity demand may fall into higher slabs with commercial rates.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Traffic Rates:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Tariff rates for each slab are set by the government or the respective electricity regulatory authority. These rates may vary depending on factors such as geographical location, time of day, and seasonal variations.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Impact on Consumers:  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'Electricity slabs impact consumers by influencing their electricity bills. Staying within lower slabs or optimizing consumption to avoid moving into higher slabs can help consumers save money on their electricity bills.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Government Subsidies and Assistance:   ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: wColor),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  'To alleviate the burden of electricity costs on low-income households, governments may provide subsidies or financial assistance. These initiatives help ensure that essential electricity services remain affordable for all segments of society.',
                  style: TextStyle(fontSize: 16, color: wColor),
                  textAlign: TextAlign.justify, // Set text alignment to justify
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

//Area Chart

// Spline chart
