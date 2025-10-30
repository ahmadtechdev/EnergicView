import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class MLPredictionService {
  /// Returns a list of up to 12 (month, year, kWh consumption) from Firestore, latest last.
  static Future<List<Map<String, dynamic>>> getMonthlyHistory() async {
    final now = DateTime.now();
    final List<Map<String, dynamic>> result = [];
    for (int i = 11; i >= 0; i--) {
      final dt = DateTime(now.year, now.month - i, 1);
      final monthName = DateFormat('MMMM').format(dt);
      final year = dt.year.toString();
      final snapshot = await FirebaseFirestore.instance
          .collection("AcsData")
          .where("month", isEqualTo: monthName)
          .where("year", isEqualTo: year)
          .get();
      double totalAmps = 0;
      for (var doc in snapshot.docs) {
        final amps = doc.data()['amps'];
        if (amps != null) {
          totalAmps += double.tryParse(amps.toString()) ?? 0.0;
        }
      }
      double kwh = (totalAmps * 230) / 1000;
      result.add({
        'month': monthName,
        'year': year,
        'kwh': double.parse(kwh.toStringAsFixed(2)),
      });
    }
    return result;
  }

  static Map<String, double> _calculateLinearRegression(List<double> xValues, List<double> yValues) {
    final n = xValues.length;
    final xMean = xValues.reduce((a, b) => a + b) / n;
    final yMean = yValues.reduce((a, b) => a + b) / n;
    double numerator = 0;
    double denominator = 0;
    for (int i = 0; i < n; i++) {
      final xDiff = xValues[i] - xMean;
      numerator += xDiff * (yValues[i] - yMean);
      denominator += xDiff * xDiff;
    }
    final slope = denominator != 0 ? numerator / denominator : 0;
    final intercept = yMean - slope * xMean;
    return {'slope': slope.toDouble(), 'intercept': intercept.toDouble()};
  }

  /// Predict next month's energy. Returns data for the UI: { prediction, slope, intercept, historical, labels, fallbackUsed, accuracy, mae, rmse }
  static Future<Map<String, dynamic>> predictNextMonthEnergy() async {
    final monthlyData = await getMonthlyHistory();
    final yValues = <double>[];
    final xValues = <double>[];
    final monthlyLabels = <String>[];
    int idx = 0;
    for (final m in monthlyData) {
      yValues.add(m["kwh"]);
      xValues.add(idx.toDouble());
      monthlyLabels.add("${m["month"]} ${m["year"]}");
      idx++;
    }
    // Remove leading zero-usage months (to only use months with data)
    while (yValues.isNotEmpty && yValues[0] == 0) {
      yValues.removeAt(0);
      xValues.removeAt(0);
      monthlyLabels.removeAt(0);
    }
    bool fallbackUsed = false;
    double prediction = 0;
    double mae = 0, rmse = 0, accuracy = 0;
    double maePercent = 0, rmsePercent = 0;
    double slope = 0, intercept = 0;
    if (yValues.length < 2) {
      // Fallback: use average or last value.
      prediction = yValues.isNotEmpty ? yValues.last : 0;
      fallbackUsed = true;
    } else {
      final linReg = _calculateLinearRegression(xValues, yValues);
      slope = linReg['slope']!;
      intercept = linReg['intercept']!;
      final nextX = (xValues.isNotEmpty ? xValues.last + 1 : 0);
      prediction = slope * nextX + intercept;
      // Evaluation metrics (against actual for known months except the last)
      if (yValues.length > 2) {
        double sumAbs = 0, sumSq = 0, accSum = 0;
        for (int i = 0; i < yValues.length; i++) {
          final y_pred = slope * xValues[i] + intercept;
          sumAbs += (y_pred - yValues[i]).abs();
          sumSq += (y_pred - yValues[i]) * (y_pred - yValues[i]);
          // For "accuracy" metric, treat as percent-off from 100%
          if (yValues[i] != 0) accSum += (1.0 - ((y_pred - yValues[i]).abs() / yValues[i])).clamp(0, 1);
        }
        mae = sumAbs / yValues.length;
        rmse = sqrt(sumSq / yValues.length);
        accuracy = (accSum * 100) / yValues.length;
        final avgActual = yValues.isNotEmpty ? yValues.reduce((a, b) => a + b) / yValues.length : 1;
        maePercent = avgActual != 0 ? (mae / avgActual) * 100 : 0;
        rmsePercent = avgActual != 0 ? (rmse / avgActual) * 100 : 0;
      }
    }
    prediction = prediction < 0 ? 0 : prediction;
    return {
      'prediction': double.parse(prediction.toStringAsFixed(2)),
      'slope': slope,
      'intercept': intercept,
      'historical': yValues,
      'labels': monthlyLabels,
      'fallbackUsed': fallbackUsed,
      'accuracy': accuracy,
      'mae': mae,
      'rmse': rmse,
      'maePercent': maePercent,
      'rmsePercent': rmsePercent,
    };
  }
} 