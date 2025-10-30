import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:energicview/services/data_entry_service.dart';
import '../colors.dart';
import 'navbar.dart';

class ManualDataEntryScreen extends StatefulWidget {
  const ManualDataEntryScreen({Key? key}) : super(key: key);

  @override
  State<ManualDataEntryScreen> createState() => _ManualDataEntryScreenState();
}

class _ManualDataEntryScreenState extends State<ManualDataEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ampsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int? _selectedHour; // For user to pick hour

  bool _loading = false;
  bool _clearing = false;

  @override
  void initState() {
    super.initState();
    _selectedHour = DateTime.now().hour;
  }

  @override
  void dispose() {
    _ampsController.dispose();
    super.dispose();
  }

  Future<void> _addEntry() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final amps = double.parse(_ampsController.text);
      await ManualDataEntryService.addEntry(
        ampsValue: amps,
        selectedDate: _selectedDate,
        selectedHour: _selectedHour ?? DateTime.now().hour,
      );
      _ampsController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('Entry added successfully', Colors.green));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('Error: $e', Colors.red));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _clearAllData() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Clear All Data"),
        content: const Text(
            "Are you sure you want to delete all data? This cannot be undone."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          ElevatedButton(
            child: const Text("Delete All"),
            style: ElevatedButton.styleFrom(
              backgroundColor: rColor,
              foregroundColor: wColor,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    setState(() => _clearing = true);
    try {
      await ManualDataEntryService.clearAllData();
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('All data deleted', Colors.green));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('Error: $e', Colors.red));
    } finally {
      setState(() => _clearing = false);
    }
  }

  SnackBar _snack(String msg, Color color) => SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );

  void _changeDate(int delta) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: delta));
    });
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2099),
      helpText: "Select Date",
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat.yMMMMd().format(_selectedDate);
    // Removed dependency on user changing the date.
    final canSubmit = !_loading && _formKey.currentState?.validate() == true;
    List<DropdownMenuItem<int>> hourItems = List.generate(
        24,
        (i) => DropdownMenuItem(
              value: i,
              child: Text(i.toString().padLeft(2, '0'), style: TextStyle(color: wColor)),
            ));
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: pColor,
        foregroundColor: wColor,
        centerTitle: true,
        title: const Text('Manual Data Entry'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      backgroundColor: pColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                color: pColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.data_thresholding, color: yColor),
                            const SizedBox(width: 8),
                            Text(
                              'Manual Data Entry',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23, letterSpacing: 0.2, color: wColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Text("Amps Value", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: yColor)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _ampsController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(color: wColor, fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: p1Color,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            labelText: 'Amps Value',
                            hintText: 'Enter amps (e.g., 45.67)',
                            prefixIcon: Icon(Icons.flash_on, color: y1Color),
                            labelStyle: TextStyle(color: y1Color, fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(color: y1Color),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Required';
                            final num = double.tryParse(val);
                            if (num == null) return 'Must be a valid decimal number';
                            if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(val)) return 'Max 2 decimals';
                            return null;
                          },
                          enabled: !_loading,
                          onChanged: (val) { setState((){}); },
                        ),
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: yColor),
                            const SizedBox(width: 8),
                            Text('Select Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: wColor)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_left),
                              color: yColor,
                              tooltip: 'Previous day',
                              onPressed: _loading ? null : () {
                                setState(() => _selectedDate = _selectedDate.subtract(const Duration(days: 1)));
                              },
                            ),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: _loading ? null : _showDatePicker,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateFormat.yMMMMd().format(_selectedDate),
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: wColor),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              color: yColor,
                              tooltip: 'Next day',
                              onPressed: _loading ? null : () {
                                setState(() => _selectedDate = _selectedDate.add(const Duration(days: 1)));
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.calendar_month, size: 18),
                            label: const Text("Open Calendar"),
                            onPressed: _loading ? null : _showDatePicker,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: yColor,
                              foregroundColor: wColor,
                              minimumSize: const Size(140, 38),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: yColor),
                            const SizedBox(width: 8),
                            Text('Select Hour (optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: wColor)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          value: _selectedHour,
                          items: hourItems,
                          dropdownColor: p1Color,
                          onChanged: _loading ? null : (val) => setState(() => _selectedHour = val),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: p1Color,
                            labelText: "Hour (24h, optional)",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.schedule, color: y1Color),
                            labelStyle: TextStyle(color: y1Color, fontWeight: FontWeight.w600),
                          ),
                          style: TextStyle(color: wColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 56,
                          child: AbsorbPointer(
                            absorbing: !canSubmit || _loading,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add_circle, size: 23),
                              label: _loading
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.8),
                                    )
                                  : const Text('Add Entry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canSubmit && !_loading ? greenColor.withOpacity(1.0) : greenColor.withOpacity(0.55),
                                foregroundColor: wColor,
                                elevation: 2,
                                textStyle: const TextStyle(fontWeight: FontWeight.w700),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (canSubmit && !_loading) {
                                  _addEntryWithHour();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Fully red background for clear all data
                        Container(
                          decoration: BoxDecoration(
                            color: rColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 54,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.delete, size: 19, color: Colors.white),
                            label: _clearing
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("Clear All Data", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _clearing ? null : _clearAllData,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addEntryWithHour() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final amps = double.parse(_ampsController.text);
      final selectedHour = _selectedHour ?? DateTime.now().hour;
      await ManualDataEntryService.addEntry(
        ampsValue: amps,
        selectedDate: _selectedDate,
        selectedHour: selectedHour,
      );
      _ampsController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('Entry added successfully', Colors.green));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snack('Error: $e', Colors.red));
    } finally {
      setState(() => _loading = false);
    }
  }
}
