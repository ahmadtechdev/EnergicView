// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../colors.dart';
import 'graphs/doughnut_graph.dart';
import 'navbar.dart';
import 'relay_control.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentValue = 0;

  int _liveValue1 = 0;
  int _liveValue2 = 0;
  int _liveValue3 = 0;
  int _liveValue4 = 0;
  int _liveValue5 = 0;

  @override
  void initState() {
    super.initState();
    _startListeningToFirestore();

  }

  final now = DateTime.now();
  double totalAmpsThisMonth = 0;
  double totalAmpsPreviousMonth = 0;
  double totalAmpsThisDay = 0;
  double totalAmpsPreviousDay = 0;

  Future<double> SumOfAmpsThisMonth() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    String currentMonth = DateFormat('MMMM').format(now);
    final currentMonthYear = now.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: currentMonth)
        .where("year", isEqualTo: currentMonthYear.toString())
        .get();
    totalAmpsThisMonth = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsThisMonth += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsThisMonth=(totalAmpsThisMonth*230)/1000;
    return totalAmpsThisMonth;
  }

  Future<double> SumOfAmpsThisDay() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final currentDayMonth = DateFormat('MMMM').format(now);
    final currentDayYear = now.year;
    final currentDay = now.day;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: currentDayMonth)
        .where("year", isEqualTo: currentDayYear.toString())
        .where("date", isEqualTo: currentDay.toString())
        .get();
    totalAmpsThisDay = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsThisDay += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsThisDay=(totalAmpsThisDay*230)/1000;
    return totalAmpsThisDay;
  }

  Future<double> SumOfAmpsPreviousDay() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final previousDayTime = now.subtract(Duration(days: 1));
    final previousDayMonth = DateFormat('MMMM').format(previousDayTime);
    final previousDayYear = previousDayTime.year;
    final previousDay = previousDayTime.day;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: previousDayMonth)
        .where("year", isEqualTo: previousDayYear.toString())
        .where("date", isEqualTo: previousDay.toString())
        .get();
    totalAmpsPreviousDay = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsPreviousDay += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsPreviousDay=(totalAmpsPreviousDay*230)/1000;
    return totalAmpsPreviousDay;
  }

  Future<double> SumOfAmpsPreviousMonth() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final previousMonth = now.subtract(Duration(days: now.day));

    // Format the previous month as a three-letter abbreviation
    final previousMonthName = DateFormat('MMMM').format(previousMonth);
    final previousMonthYear = previousMonth.year;
    print("month: $previousMonthName year: $previousMonthYear");
    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: previousMonthName)
        .where("year", isEqualTo: previousMonthYear.toString())
        .get();
    totalAmpsPreviousMonth = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsPreviousMonth += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsPreviousMonth=(totalAmpsPreviousMonth*230)/1000;
    return totalAmpsPreviousMonth;
  }
  // final _database = FirebaseDatabase.instance.ref();
  Future<void> _startListeningToFirestore() async {
    // DataSnapshot snapshot = (await _database.child('AcsData/reading').once()).snapshot;
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref('AcsData/reading');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      double value = (double.parse(data.toString())) * 230;
      int newValue = value.round();

      _liveValue1 = _liveValue2;
      _liveValue2 = _liveValue3;
      _liveValue3 = _liveValue4;
      _liveValue4 = _liveValue5;
      if (newValue < 0.1) {
        _liveValue5 = 0;
      } else {
        _liveValue5 = newValue;
      }

      if (newValue != _currentValue) {
        setState(() {
          _currentValue = newValue;
        });
      }
    });
  }

  Future<Map<String, double>> getAllAmpValues() async {
    final monthAmps = await SumOfAmpsThisMonth();
    final dayAmps = await SumOfAmpsThisDay();
    final previousDayAmps = await SumOfAmpsPreviousDay();
    final previousMonthAmps = await SumOfAmpsPreviousMonth();
    return {
      'monthAmps': monthAmps,
      'dayAmps': dayAmps,
      'previousDayAmps': previousDayAmps,
      'previousMonthAmps': previousMonthAmps,
    };
  }



  @override
  Widget build(BuildContext context) {
    final List<currentData> chartData = [
      currentData(1, _liveValue1),
      currentData(2, _liveValue2),
      currentData(3, _liveValue3),
      currentData(4, _liveValue4),
      currentData(5, _liveValue5),
    ];

    return FutureBuilder<Map<String, double>>(
      future: getAllAmpValues(),
      builder: (context, snapshot) {

          return Scaffold(
              drawer: NavBar(),
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: pColor,
                title: Text(
                  "Home", style: TextStyle(color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
                ),
                foregroundColor: wColor,
                toolbarHeight: MediaQuery.of(context).size.height / 10, // Set your desired height here
              ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: pColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Live Usage",
                              style: TextStyle(
                                  color: y1Color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${_currentValue} watts",
                              style: TextStyle(
                                  color: yColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: p1Color,
                        // borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${totalAmpsThisDay.toStringAsFixed(2)} Kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Yesterday",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${totalAmpsPreviousDay.toStringAsFixed(2)} kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Difference",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${(totalAmpsThisDay - totalAmpsPreviousDay)
                                        .toStringAsFixed(2)} kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "This Month",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${totalAmpsThisMonth.toStringAsFixed(2)} Kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Previous Month",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${totalAmpsPreviousMonth.toStringAsFixed(2)} Kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Difference",
                                    style: TextStyle(
                                        color: y1Color,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${(totalAmpsThisMonth - totalAmpsPreviousMonth)
                                        .toStringAsFixed(2)} Kwh",
                                    style: TextStyle(
                                        color: yColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SfCartesianChart(series: <ChartSeries>[
                        // Renders area chart
                        AreaSeries<currentData, int>(
                            dataSource: chartData,
                            color: yColor.withOpacity(0.8),
                            xValueMapper: (currentData data, _) => data.dataPoint,
                            yValueMapper: (currentData data, _) => data.value)
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: yColor, width: 2.0))),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: pColor,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.lightbulbMultiple,
                    ),
                    label: 'Relay',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MdiIcons.chartPie),
                    label: 'Usage',
                  ),

                ],
                currentIndex: 0,
                selectedItemColor: yColor,
                unselectedItemColor: y1Color,
                onTap: onTabTapped,
              ),
            ),
          );

      },
    );
  }

  void onTabTapped(int index) {
    if (index == 0) {
      Get.to(() => HomeScreen());
    } else if (index == 1) {
      Get.to(() => RelayControl());
    } else if (index == 2) {
      Get.to(() => YesterdayHoursData());
    }
  }
}

class currentData {
  currentData(this.dataPoint, this.value);
  final int dataPoint;
  final int value;
}
