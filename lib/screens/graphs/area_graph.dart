import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../colors.dart';
import '../home_screen.dart';
import '../navbar.dart';

class PreviousSixMonthData extends StatefulWidget {
  const PreviousSixMonthData({super.key});

  @override
  State<PreviousSixMonthData> createState() => _PreviousSixMonthDataState();
}

class _PreviousSixMonthDataState extends State<PreviousSixMonthData> {

  final now = DateTime.now();


  double totalAmpsOneMonthBack = 0;
  double totalAmpsThreeMonthBack = 0;
  double totalAmpsTwoMonthBack = 0;
  double totalAmpsFourMonthBack = 0;
  double totalAmpsFiveMonthBack = 0;
  double totalAmpsSixMonthBack = 0;


  Future<double> SumOfAmpsOneMonthBack() async {

    final monthTime = now.subtract(Duration(days: now.day));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsOneMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsOneMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsOneMonthBack = (totalAmpsOneMonthBack * 230) / 1000;
    totalAmpsOneMonthBack =
        double.parse(totalAmpsOneMonthBack.toStringAsFixed(2));
    return totalAmpsOneMonthBack;
  }

  Future<double> SumOfAmpsTwoMonthBack() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 30));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsTwoMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsTwoMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsTwoMonthBack = (totalAmpsTwoMonthBack * 230) / 1000;
    totalAmpsTwoMonthBack =
        double.parse(totalAmpsTwoMonthBack.toStringAsFixed(2));
    return totalAmpsTwoMonthBack;
  }

  Future<double> SumOfAmpsThreeMonthBack() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 61));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsThreeMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsThreeMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsThreeMonthBack = (totalAmpsThreeMonthBack * 230) / 1000;
    totalAmpsThreeMonthBack =
        double.parse(totalAmpsThreeMonthBack.toStringAsFixed(2));
    return totalAmpsThreeMonthBack;
  }

  Future<double> SumOfAmpsFourMonthBack() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 90));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsFourMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsFourMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsFourMonthBack = (totalAmpsFourMonthBack * 230) / 1000;
    totalAmpsFourMonthBack =
        double.parse(totalAmpsFourMonthBack.toStringAsFixed(2));
    return totalAmpsFourMonthBack;
  }

  Future<double> SumOfAmpsFiveMonthBack() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 120));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsFiveMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsFiveMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsFiveMonthBack = (totalAmpsFiveMonthBack * 230) / 1000;
    totalAmpsFiveMonthBack =
        double.parse(totalAmpsFiveMonthBack.toStringAsFixed(2));
    return totalAmpsFiveMonthBack;
  }

  Future<double> SumOfAmpsSixMonthBack() async {
    // Format the month as a three-letter abbreviation (e.g., Apr)
    final monthTime = now.subtract(Duration(days: now.day + 150));
    final month = DateFormat('MMMM').format(monthTime);
    final monthYear = monthTime.year;

    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: monthYear.toString())
        .get();
    totalAmpsSixMonthBack = 0;

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        // Check if amps exist and convert to double before adding
        totalAmpsSixMonthBack += double.tryParse(amps) ?? 0.0;
      }
    }
    totalAmpsSixMonthBack = (totalAmpsSixMonthBack * 230) / 1000;
    totalAmpsSixMonthBack =
        double.parse(totalAmpsSixMonthBack.toStringAsFixed(2));
    return totalAmpsSixMonthBack;
  }

  List<currentData1> _chartData() {
    return <currentData1>[
      currentData1(1, totalAmpsOneMonthBack),
      currentData1(2, totalAmpsTwoMonthBack),
      currentData1(3, totalAmpsThreeMonthBack),
      currentData1(4, totalAmpsFourMonthBack),
      currentData1(5, totalAmpsFiveMonthBack),
      currentData1(6, totalAmpsSixMonthBack),
    ];
  }


  Future<Map<String, double>> getAllAmpValues() async {

    final oneMonth = await SumOfAmpsOneMonthBack();
    final TwoMonth = await SumOfAmpsTwoMonthBack();
    final ThreMonth = await SumOfAmpsThreeMonthBack();
    final FourMonth = await SumOfAmpsFourMonthBack();
    final FiveMonth = await SumOfAmpsFiveMonthBack();
    final SixMonth = await SumOfAmpsSixMonthBack();

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
                          height: 30,
                        ),
                        const Text(
                          "Previous Six Months ",
                          style: TextStyle(
                              color: yColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: SfCartesianChart(series: <CartesianSeries>[
                            // Renders area chart
                            AreaSeries<currentData1, int>(
                                dataSource: _chartData(),
                                color: yColor.withOpacity(0.8),
                                xValueMapper: (currentData1 data, _) =>
                                data.dataPoint,
                                yValueMapper: (currentData1 data, _) =>
                                data.value)
                          ]),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Text(
                                "Last Six Months : ",
                                style: TextStyle(
                                    color: y1Color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                              Text(
                                "${(totalAmpsOneMonthBack + totalAmpsTwoMonthBack + totalAmpsThreeMonthBack + totalAmpsFourMonthBack + totalAmpsFiveMonthBack + totalAmpsSixMonthBack).toStringAsFixed(2)} Kwh",
                                style: const TextStyle(
                                    color: yColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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

class currentData1 {
  final int dataPoint;
  final double value;

  currentData1(this.dataPoint, this.value);
}