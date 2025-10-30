import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../colors.dart';
import '../navbar.dart';

class LastTwoMonthCompare extends StatefulWidget {
  const LastTwoMonthCompare({super.key});

  @override
  State<LastTwoMonthCompare> createState() => _LastTwoMonthCompareState();
}

class _LastTwoMonthCompareState extends State<LastTwoMonthCompare> {
  final now = DateTime.now();

  double totalAmpsQuarterOne = 0;
  double totalAmpsQuarterTwo = 0;
  double totalAmpsQuarterThree = 0;
  double totalAmpsQuarterFour = 0;
  double totalAmpsQuarterFive = 0;
  double totalAmpsQuarterOne1 = 0;
  double totalAmpsQuarterTwo2 = 0;
  double totalAmpsQuarterThree3 = 0;
  double totalAmpsQuarterFour4 = 0;
  double totalAmpsQuarterFive5 = 0;

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

  Future<double> SumOfAmpsQuarterOne1() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 31));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["1", "2", "3", "4", "5", "6"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterOne1 = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterOne1 += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterOne1 = (totalAmpsQuarterOne1 * 230) / 1000;
    totalAmpsQuarterOne1 =
        double.parse(totalAmpsQuarterOne1.toStringAsFixed(2));
    return totalAmpsQuarterOne1;
  }

  Future<double> SumOfAmpsQuarterTwo2() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 31));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["7", "8", "9", "10", "11", "12"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterTwo2 = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterTwo2 += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterTwo2 = (totalAmpsQuarterTwo2 * 230) / 1000;
    totalAmpsQuarterTwo2 =
        double.parse(totalAmpsQuarterTwo2.toStringAsFixed(2));
    return totalAmpsQuarterTwo2;
  }

  Future<double> SumOfAmpsQuarterThree3() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 31));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["13", "14", "15", "16", "17", "18"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterThree3 = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterThree3 += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterThree3 = (totalAmpsQuarterThree3 * 230) / 1000;
    totalAmpsQuarterThree3 =
        double.parse(totalAmpsQuarterThree3.toStringAsFixed(2));
    return totalAmpsQuarterThree3;
  }

  Future<double> SumOfAmpsQuarterFour4() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 31));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["19", "20", "21", "22", "23", "24"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterFour4 = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterFour4 += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterFour4 = (totalAmpsQuarterFour4 * 230) / 1000;
    totalAmpsQuarterFour4 =
        double.parse(totalAmpsQuarterFour4.toStringAsFixed(2));
    return totalAmpsQuarterFour4;
  }

  Future<double> SumOfAmpsQuarterFive5() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 31));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where('date', whereIn: ["25", "26", "27", "28", "29", "30", "31"])
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsQuarterFive5 = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsQuarterFive5 += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsQuarterFive5 = (totalAmpsQuarterFive5 * 230) / 1000;
    totalAmpsQuarterFive5 =
        double.parse(totalAmpsQuarterFive5.toStringAsFixed(2));
    return totalAmpsQuarterFive5;
  }

  Future<Map<String, double>> getAllAmpValues() async {
    final QuarterOne = await SumOfAmpsQuarterOne();
    final QuarterTwo = await SumOfAmpsQuarterTwo();
    final QuarterThree = await SumOfAmpsQuarterThree();
    final QuarterFour = await SumOfAmpsQuarterFour();
    final QuarterFive = await SumOfAmpsQuarterFive();
    final QuarterOne1 = await SumOfAmpsQuarterOne1();
    final QuarterTwo2 = await SumOfAmpsQuarterTwo2();
    final QuarterThree3 = await SumOfAmpsQuarterThree3();
    final QuarterFour4 = await SumOfAmpsQuarterFour4();
    final QuarterFive5 = await SumOfAmpsQuarterFive5();

    return {};
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
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Last Two Month Comparison",
                          style: TextStyle(
                              color: yColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(text: 'KWH'),
                            ),
                            series: <CartesianSeries>[
                              SplineSeries<SalesData, String>(
                                dataSource: <SalesData>[
                                  SalesData('1', totalAmpsQuarterOne,
                                      'Date A'), // Example data for Date A
                                  SalesData('2', totalAmpsQuarterTwo,
                                      'Date A'), // Example data for Date A
                                  SalesData('3', totalAmpsQuarterThree,
                                      'Date A'), // Example data for Date A
                                  SalesData('4', totalAmpsQuarterFour,
                                      'Date A'), // Example data for Date A
                                  SalesData('5', totalAmpsQuarterFive,
                                      'Date A'), // Example data for Date A
                                  // Example data for Date A
                                  // Example data for Date A
                                  // Add more data points for Date A here
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.hour,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.ampUsage,
                                name: 'Date A',
                                color: Colors
                                    .blue, // Change color as needed for Date A
                              ),
                              SplineSeries<SalesData, String>(
                                dataSource: <SalesData>[
                                  SalesData('1', totalAmpsQuarterOne1,
                                      'Date B'), // Example data for Date A
                                  SalesData(
                                      '2', totalAmpsQuarterTwo2, 'Date B'),
                                  SalesData(
                                      '3', totalAmpsQuarterThree3, 'Date B'),
                                  SalesData(
                                      '4', totalAmpsQuarterFour4, 'Date B'),
                                  SalesData('5', totalAmpsQuarterFive5,
                                      'Date B'), // Example data for Date A
                                  // Example data for Date A// Example data for Date B
                                  // Add more data points for Date B here
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.hour,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.ampUsage,
                                name: 'Date B',
                                color: Colors
                                    .green, // Change color as needed for Date B
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Blue Line for Last Month",
                              style: TextStyle(
                                  color: wColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Green Line for Second Last Month",
                              style: TextStyle(
                                  color: wColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        )
                        ,

                        const SizedBox(
                          height: 170,
                        )
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

class SalesData {
  final String hour;
  final double ampUsage;
  final String date;

  SalesData(this.hour, this.ampUsage, this.date);
}
