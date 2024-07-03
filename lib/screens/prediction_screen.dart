import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../colors.dart';
import 'navbar.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> with SingleTickerProviderStateMixin{

  DateFormat _dateFormat = DateFormat('MMMM yyyy');

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final now = DateTime.now();
  double totalAmpsPreviousMonth = 0;
  double preMonthUsagePercentage = 0;
  double predictedUsage = 0;
  double temp = 0;


  Future<double> SumOfAmpsPreviousMonth() async {
    final previousMonth = now.subtract(Duration(days: now.day));
    final previousMonthName = DateFormat('MMMM').format(previousMonth);
    final previousMonthYear = previousMonth.year;
    final snapshot = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: previousMonthName)
        .where("year", isEqualTo: previousMonthYear.toString())
        .get();

    totalAmpsPreviousMonth = 0;

    for (var doc in snapshot.docs) {
      final amps = doc.data()?['amps'];
      if (amps != null) {
        totalAmpsPreviousMonth += double.tryParse(amps) ?? 0.0;
      }
    }
    //230 for direct current
    totalAmpsPreviousMonth = (totalAmpsPreviousMonth * 230) / 1000;

    final snapshot1 = await FirebaseFirestore.instance
        .collection("prediction")
        .doc(previousMonthName)
        .get();

    double targetPreMonth = double.tryParse(snapshot1.data()?['value']) ?? 0.0;
    preMonthUsagePercentage = ((totalAmpsPreviousMonth * 100) / targetPreMonth);

    String currentMonth = DateFormat('MMMM').format(now);

    final snapshot2 = await FirebaseFirestore.instance
        .collection("prediction")
        .doc(currentMonth)
        .get();

    double targetThisMonth = double.tryParse(snapshot2.data()?['value']) ?? 0.0;
    predictedUsage = (preMonthUsagePercentage * targetThisMonth) / 100;


    final twoMonthsAgo = now.subtract(Duration(days: now.day + 31));
    final twoMonthsAgoName = DateFormat('MMMM').format(twoMonthsAgo);
    final twoMonthAgoYear = twoMonthsAgo.year;
    final snapshot3 = await FirebaseFirestore.instance
        .collection("AcsData")
        .where("month", isEqualTo: twoMonthsAgoName)
        .where("year", isEqualTo: twoMonthAgoYear.toString())
        .get();
    temp = 0;
    for (var doc in snapshot3.docs) {
      final amps1 = doc.data()?['amps'];
      if (amps1 != null) {
        temp += double.tryParse(amps1) ?? 0.0;
      }
    }

    await FirebaseFirestore.instance
        .collection("prediction")
        .doc(twoMonthsAgoName)
        .update({
      'value': temp.round(),
    }).then((value) => {print("transaction update:$temp")});

    return predictedUsage;
  }

  Future<Map<String, double>> getAllAmpValues() async {
    final monthAmps = await SumOfAmpsPreviousMonth();

    return {
      'monthAmps': monthAmps,
    };
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = _dateFormat.format(now);

    return FutureBuilder<Map<String, double>>(
        future: getAllAmpValues(),
        builder: (context, snapshot) {
          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: pColor,
              title: const Text(
                "Expected Usage",
                style: TextStyle(
                    color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
              ),
              foregroundColor: wColor,
              toolbarHeight: MediaQuery.of(context).size.height /
                  10, // Set your desired height here
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: pColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Container(
                            width: 150 ,
                            height: 150 ,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: yColor,
                            ),
                            child: Center(

                              child: Text(
                                "${predictedUsage.toStringAsFixed(2)} Kwh",
                                style: const TextStyle(
                                  color: wColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 200.0,
                      child:
                      Lottie.asset("assets/animations/Animation - predict.json"),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    //For month and year
                    Center(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1 + 0.1 * _animation.value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
