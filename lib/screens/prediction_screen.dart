import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../colors.dart';
import 'navbar.dart';
import 'package:energicview/services/ml_prediction_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    return FutureBuilder<Map<String, dynamic>>(
      future: MLPredictionService.predictNextMonthEnergy(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final prediction = data != null ? data['prediction'] as double : 0.0;
        final acc = data != null ? data['accuracy'] : 0.0;
        final mae = data != null ? data['mae'] : 0.0;
        final rmse = data != null ? data['rmse'] : 0.0;
        final fallback = data != null ? data['fallbackUsed'] == true : true;
        final model = 'Linear Regression (Least Squares)';
        final slope = data != null ? data['slope'] : 0.0;
        final intercept = data != null ? data['intercept'] : 0.0;
        final historical = data != null ? data['historical'] as List<double> : [];
        final labels = data != null ? List<String>.from(data['labels'] ?? []) : [];
        List<_ChartPoint> chartData = [];
        if (historical.isNotEmpty && labels.isNotEmpty) {
          for (int i = 0; i < historical.length; i++) {
            chartData.add(_ChartPoint(labels[i], historical[i]));
          }
          chartData.add(_ChartPoint(
            'Predicted',
            prediction,
            isPrediction: true,
          ));
        }
        final maePercent = data != null ? data['maePercent'] : 0.0;
        final rmsePercent = data != null ? data['rmsePercent'] : 0.0;
        return Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            backgroundColor: pColor,
            title: const Text("Predicted Consumption - ML"),
            foregroundColor: wColor,
            centerTitle: true,
          ),
          backgroundColor: pColor,
          body: snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Lottie.asset("assets/animations/Animation - predict.json", width: 120, repeat: true),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            color: p1Color,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                              child: Column(
                                children: [
                                  Text('Predicted Energy Consumption',
                                      style: TextStyle(
                                          color: wColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                          letterSpacing: 0.1)),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${prediction.toStringAsFixed(2)} kWh",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 42,
                                      color: yColor,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.science, size: 18, color: greenColor),
                                        const SizedBox(width: 6),
                                        Text('Model: $model', style: TextStyle(color: y1Color, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  fallback
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.warning, color: Colors.orangeAccent, size: 18),
                                              const SizedBox(width: 5),
                                              const Text('Fallback to Average (Insufficient Data)', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                            color: p1Color,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _MetricTile(label: 'Accuracy', value: acc, suffix: '%', dark: true),
                                  _MetricTile(label: 'MAE', value: mae, suffix: 'kWh', dark: true, percentValue: maePercent),
                                  _MetricTile(label: 'RMSE', value: rmse, suffix: 'kWh', dark: true, percentValue: rmsePercent),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (chartData.isNotEmpty)...[
                            Text('Monthly Usage & Prediction', style: TextStyle(color: wColor, fontWeight: FontWeight.w700, fontSize: 18)),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 280,
                              child: SfCartesianChart(
                                backgroundColor: pColor,
                                plotAreaBorderColor: Colors.black54,
                                primaryXAxis: CategoryAxis(
                                  labelStyle: TextStyle(color: wColor, fontWeight: FontWeight.w700),
                                  axisLine: AxisLine(color: y1Color),
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(text: 'kWh', textStyle: TextStyle(color: wColor, fontWeight: FontWeight.bold)),
                                  labelStyle: TextStyle(color: wColor, fontWeight: FontWeight.bold),
                                  axisLine: const AxisLine(width: 1, color: y1Color),
                                ),
                                legend: Legend(isVisible: false),
                                series: <CartesianSeries<_ChartPoint, String>>[
                                  LineSeries<_ChartPoint, String>(
                                    dataSource: chartData,
                                    xValueMapper: (pt, _) => pt.label,
                                    yValueMapper: (pt, _) => pt.value,
                                    color: greenColor,
                                    markerSettings: const MarkerSettings(isVisible: true),
                                    dataLabelSettings: const DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.top, textStyle: TextStyle(color: Colors.white)),
                                    dashArray: [4,2],
                                  ),
                                  ColumnSeries<_ChartPoint, String>(
                                    dataSource: chartData,
                                    xValueMapper: (pt, _) => pt.label,
                                    yValueMapper: (pt, _) => pt.value,
                                    pointColorMapper: (pt, _) => pt.isPrediction ? greenColor : yColor,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          Card(
                            color: pColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.info_outline, color: yColor),
                                      const SizedBox(width: 7),
                                      Text('ML Model Details', style: TextStyle(color: yColor, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Algorithm: Linear Regression (y = mx + b)', style: TextStyle(color: y1Color, fontWeight: FontWeight.bold)),
                                  Text('Slope:  slope.toStringAsFixed(3)}  |  Intercept: ${intercept.toStringAsFixed(3)}', style: TextStyle(color: y1Color, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  const Text('Features: Historical kWh, seasonal trend, monthly stats', style: TextStyle(fontSize: 13, color: Colors.white70)),
                                  const SizedBox(height: 6),
                                  const Text('Metrics: Accuracy, MAE, RMSE, fallback status', style: TextStyle(fontSize: 13, color: Colors.white70)),
                                  const SizedBox(height: 4),
                                  Text(
                                      'This prediction system uses linear regression to model historical trends and forecast next month’s consumption, including fallback robustness. Ideal for academic demonstration and research reproducibility.',
                                      style: TextStyle(fontSize: 13, color: Colors.white)),
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _ChartPoint {
  final String label;
  final double value;
  final bool isPrediction;
  const _ChartPoint(this.label, this.value, {this.isPrediction = false});
}

class _MetricTile extends StatelessWidget {
  final String label;
  final double value;
  final String suffix;
  final bool dark;
  final double? percentValue;
  const _MetricTile({required this.label, required this.value, this.suffix = '', this.dark = false, this.percentValue});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: wColor),
        ),
        const SizedBox(height: 3),
        Text(
          value.isFinite ? value.toStringAsFixed(2) : '--',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: dark ? Colors.deepPurpleAccent : Colors.deepPurple),
        ),
        Text(suffix, style: const TextStyle(fontSize: 10)),
        if (percentValue != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              percentValue!.isFinite ? '(${percentValue!.toStringAsFixed(2)}%)' : '',
              style: TextStyle(fontSize: 10, color: Colors.greenAccent.withOpacity(0.85)),
            ),
          ),
      ],
    );
  }
}
