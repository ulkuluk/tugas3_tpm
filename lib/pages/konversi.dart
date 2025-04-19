import 'package:flutter/material.dart';

class TimeConversionPage extends StatefulWidget {
  const TimeConversionPage({super.key});

  @override
  _TimeConversionPageState createState() => _TimeConversionPageState();
}

class _TimeConversionPageState extends State<TimeConversionPage> {
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  String _yearResult = '';
  String _dayResult = '';

  void _convertYearToTime() {
    final year = int.tryParse(_yearController.text);
    if (year != null && year > 0) {
      int totalHours = year * 365 * 24;
      int totalMinutes = totalHours * 60;
      int totalSeconds = totalMinutes * 60;

      setState(() {
        _yearResult =
            '$year tahun = $totalHours jam, $totalMinutes menit, $totalSeconds detik';
      });
    } else {
      setState(() {
        _yearResult = 'Input tidak valid';
      });
    }
  }

  void _convertDayToTime() {
    final days = int.tryParse(_dayController.text);
    if (days != null && days > 0) {
      int totalHours = days * 24;
      int totalMinutes = totalHours * 60;
      int totalSeconds = totalMinutes * 60;

      setState(() {
        _dayResult =
            '$days hari = $totalHours jam, $totalMinutes menit, $totalSeconds detik';
      });
    } else {
      setState(() {
        _dayResult = 'Input tidak valid';
      });
    }
  }

  Widget _buildConversionCard({
    required String title,
    required TextEditingController controller,
    required VoidCallback onPressed,
    required String result,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Angka',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Konversi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Konversi Waktu'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConversionCard(
              title: 'Konversi Tahun ke Waktu',
              controller: _yearController,
              onPressed: _convertYearToTime,
              result: _yearResult,
            ),
            _buildConversionCard(
              title: 'Konversi Hari ke Waktu',
              controller: _dayController,
              onPressed: _convertDayToTime,
              result: _dayResult,
            ),
          ],
        ),
      ),
    );
  }
}