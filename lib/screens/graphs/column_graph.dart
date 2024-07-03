import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../colors.dart';
import '../home_screen.dart';
import '../navbar.dart';

class LastMonth extends StatefulWidget {
  const LastMonth({super.key});

  @override
  State<LastMonth> createState() => _LastMonthState();
}

class _LastMonthState extends State<LastMonth> {


  final now = DateTime.now();

  double totalAmpsQuarterOne = 0;
  double totalAmpsQuarterTwo = 0;
  double totalAmpsQuarterThree = 0;
  double totalAmpsQuarterFour = 0;
  double totalAmpsQuarterFive = 0;

  Future<double> SumOfAmpsQuarterOne() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["1", "2", "3", "4", "5", "6"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterOne = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterOne += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterOne = (totalAmpsQuarterOne * 230) / 1000;
    totalAmpsQuarterOne = double.parse(totalAmpsQuarterOne.toStringAsFixed(2));
    return totalAmpsQuarterOne;
  }

  Future<double> SumOfAmpsQuarterTwo() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["7", "8", "9", "10", "11", "12"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterTwo = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterTwo += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterTwo = (totalAmpsQuarterTwo * 230) / 1000;
    totalAmpsQuarterTwo = double.parse(totalAmpsQuarterTwo.toStringAsFixed(2));
    return totalAmpsQuarterTwo;
  }

  Future<double> SumOfAmpsQuarterThree() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["13", "14", "15", "16", "17", "18"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterThree = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterThree += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterThree = (totalAmpsQuarterThree * 230) / 1000;
    totalAmpsQuarterThree =
        double.parse(totalAmpsQuarterThree.toStringAsFixed(2));
    return totalAmpsQuarterThree;
  }

  Future<double> SumOfAmpsQuarterFour() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["19", "20", "21", "22", "23", "24"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterFour = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterFour += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterFour = (totalAmpsQuarterFour * 230) / 1000;
    totalAmpsQuarterFour =
        double.parse(totalAmpsQuarterFour.toStringAsFixed(2));
    return totalAmpsQuarterFour;
  }

  Future<double> SumOfAmpsQuarterFive() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["25", "26", "27", "28", "29", "30", "31"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterFive = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterFive += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterFive = (totalAmpsQuarterFive * 230) / 1000;
    totalAmpsQuarterFive =
        double.parse(totalAmpsQuarterFive.toStringAsFixed(2));
    return totalAmpsQuarterFive;
  }

  Future<Map<String, double>> getAllAmpValues() async {


    final QuarterOne = await SumOfAmpsQuarterOne();
    final QuarterTwo = await SumOfAmpsQuarterTwo();
    final QuarterThree = await SumOfAmpsQuarterThree();
    final QuarterFour = await SumOfAmpsQuarterFour();
    final QuarterFive = await SumOfAmpsQuarterFive();

    return {

    };
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: getAllAmpValues(),
      builder: (context, snapshot) {

          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: pColor,

              title: const Text("Data Analytics", style: TextStyle(fontWeight: FontWeight.bold),),
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

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Last Month Data",
                          style: TextStyle(
                              color: yColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22 ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(text: 'KWH'),
                                ),
                                series: <ChartSeries>[
                                  ColumnSeries<Map<String, num>, String>(
                                    dataSource: [
                                      {'date': 1, 'amps': totalAmpsQuarterOne},
                                      {'date': 2, 'amps': totalAmpsQuarterTwo},
                                      {'date': 3, 'amps': totalAmpsQuarterThree},
                                      {'date': 4, 'amps': totalAmpsQuarterFour},
                                      {'date': 5, 'amps': totalAmpsQuarterFive},
                                    ],
                                    xValueMapper: (Map<String, num> amp, _) =>
                                        amp['date'].toString(),
                                    yValueMapper: (Map<String, num> amp, _) =>
                                    amp['amps'],
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold// Set text color to white
                                      ),
                                    ),
                                    color: yColor, // Set the column color to blue
                                  ),
                                ],
                              ),
                            ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Last Months: ",
                              style: TextStyle(
                                  color: y1Color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Text(
                              "${totalAmpsQuarterOne+totalAmpsQuarterTwo+totalAmpsQuarterThree+totalAmpsQuarterFour+totalAmpsQuarterFive} Kwh",
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

                      ],
                    ),
                  ),
                ),
              ),
            ),

          );

      },
    );
  }
}
