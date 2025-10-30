import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ManualDataEntryService {
  static final _collection = FirebaseFirestore.instance.collection('AcsData');

  /// Adds an entry to Firestore with all fields as strings, matching the ESP32 doc format and document id.
  static Future<void> addEntry({
    required double ampsValue,
    required DateTime selectedDate,
    required int selectedHour,
  }) async {
    final now = DateTime.now(); // for minute
    final hour = selectedHour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final date = selectedDate.day.toString().padLeft(2, '0');
    final month = DateFormat('MMMM').format(selectedDate); // e.g. "October"
    final year = selectedDate.year.toString();
    final counter = (Random().nextInt(200) + 1).toString();
    final amps = ampsValue.toStringAsFixed(2);
    final documentId = "$hour$minute$date$month$year";
    final docData = {
      'amps': amps,
      'counter': counter,
      'hour': hour,
      'date': date,
      'month': month,
      'year': year,
    };
    await _collection.doc(documentId).set(docData);
  }

  /// Clears all documents from the AcsData collection.
  static Future<void> clearAllData() async {
    final batch = FirebaseFirestore.instance.batch();
    final snapshots = await _collection.get();
    for (final doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
