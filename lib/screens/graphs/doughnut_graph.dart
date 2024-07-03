import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energicview/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../colors.dart';
import '../educational_content.dart';
import '../navbar.dart';
import '../relay_control.dart';

class YesterdayHoursData extends StatefulWidget {
  const YesterdayHoursData({super.key});

  @override
  State<YesterdayHoursData> createState() => _YesterdayHoursDataState();
}

class _YesterdayHoursDataState extends State<YesterdayHoursData> {
  @override
  void initState() {
    super.initState();
  }

  final now = DateTime.now();
  double totalAmpsPeakHours = 0;
  double totalAmpsOffPeakHours = 0;

  Future<double> SumOfAmpsOffPeakHours() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final previousDayTime = now.subtract(const Duration(days: 1));
    final previousDayMonth = DateFormat('MMMM').format(previousDayTime);
    final previousDayYear = previousDayTime.year;
    final previousDay = previousDayTime.day;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('hour', whereIn: [
          "00",
          "01",
          "02",
          "03",
          "04",
          "05",
          "06",
          "07",
          "08",
          "09",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15",
          "16",
          "17"
        ])
        .where("month", isEqualTo: previousDayMonth)
        .where("year", isEqualTo: previousDayYear.toString())
        .where("date", isEqualTo: previousDay.toString())
        .get();
    totalAmpsOffPeakHours = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsOffPeakHours += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsOffPeakHours = (totalAmpsOffPeakHours * 230) / 1000;
    totalAmpsOffPeakHours =
        double.parse(totalAmpsOffPeakHours.toStringAsFixed(2));
    return totalAmpsOffPeakHours;
  }

  Future<double> SumOfAmpsPeakHours() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final previousDayTime = now.subtract(const Duration(days: 1));
    final previousDayMonth = DateFormat('MMMM').format(previousDayTime);
    final previousDayYear = previousDayTime.year;
    final previousDay = previousDayTime.day;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('hour', whereIn: ["18", "19", "20", "21", "22", "23"])
        .where("month", isEqualTo: previousDayMonth)
        .where("year", isEqualTo: previousDayYear.toString())
        .where("date", isEqualTo: previousDay.toString())
        .get();
    totalAmpsPeakHours = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsPeakHours += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsPeakHours = (totalAmpsPeakHours * 230) / 1000;
    totalAmpsPeakHours = double.parse(totalAmpsPeakHours.toStringAsFixed(2));
    return totalAmpsPeakHours;
  }

  // Example function to generate dummy data
  List<AmpUsageData> _getAmpUsageData() {
    return <AmpUsageData>[
      AmpUsageData('Peak hours', totalAmpsPeakHours, 1),
      AmpUsageData('Off Peak', totalAmpsOffPeakHours, 2),
    ];
  }

  Future<Map<String, double>> getAllAmpValues() async {
    final peak = await SumOfAmpsOffPeakHours();
    final offpeak = await SumOfAmpsPeakHours();

    return {
      'peak': peak,
      'offpeak': offpeak,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: getAllAmpValues(),
      builder: (context, snapshot) {
           return Scaffold(
            drawer: NavBar(),
            appBar: AppBar(

              centerTitle: true,
              backgroundColor: pColor,
              title: const Text(
                "Data Analytics",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              foregroundColor: wColor,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: pColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Yesterday",
                          style: TextStyle(
                              color: yColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SfCircularChart(
                            series: <CircularSeries>[
                              DoughnutSeries<AmpUsageData, String>(
                                dataSource: _getAmpUsageData(),
                                xValueMapper: (AmpUsageData data, _) =>
                                    data.category,
                                yValueMapper: (AmpUsageData data, _) =>
                                    data.value,
                                dataLabelMapper: (AmpUsageData data, _) =>
                                    '${data.value} Kwh',
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight
                                          .bold // Set text color to white
                                      ),
                                ),
                                enableTooltip: true,
                                pointColorMapper: (AmpUsageData data, _) =>
                                    getDoughnutColor(
                                        data), // Adjust color as needed
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Peak hours Usage: ",
                              style: TextStyle(
                                  color: y1Color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Text(
                              "${totalAmpsPeakHours.toStringAsFixed(2)} Kwh",
                              style: const TextStyle(
                                  color: yColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Off Peak hours Usage: ",
                              style: TextStyle(
                                  color: y1Color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Text(
                              "${totalAmpsOffPeakHours.toStringAsFixed(2)} Kwh",
                              style: const TextStyle(
                                  color: yColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 170,
                        )
                      ],
                    ),
                  ),
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
                currentIndex: 2,
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

  getDoughnutColor(AmpUsageData data) {
    int value = data.indexColor;
    if (value == 1) {
      return rColor;
    } else if (value == 2) {
      return yColor;
    } else if (value == 3) {
      return yColor;
    } else {
      return yColor;
    }
  }
}

class AmpUsageData {
  final String category;
  final double value;
  final int indexColor;

  AmpUsageData(this.category, this.value, this.indexColor);
}
