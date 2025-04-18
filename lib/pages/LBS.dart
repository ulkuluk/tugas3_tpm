import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LBS extends StatefulWidget {
  const LBS({super.key});

  @override
  State<LBS> createState() => _LBSState();
}

class _LBSState extends State<LBS> {
  // ignore: unused_field
  Position? _currentPosition;
  String _locationMessage = 'Menunggu lokasi...';

  @override
  void initState() {
    super.initState();
    _deteksiLokasi(); // Panggil fungsi untuk mendapatkan lokasi sekali
  }

  Future<void> _deteksiLokasi() async {
  setState(() {
    _locationMessage = 'Menunggu lokasi...';
  });

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    setState(() {
      _locationMessage = 'Layanan lokasi tidak aktif';
    });
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        _locationMessage = 'Izin lokasi ditolak';
      });
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    setState(() {
      _locationMessage = 'Izin lokasi ditolak permanen';
    });
    return;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
      _locationMessage = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
  } catch (e) {
    setState(() {
      _locationMessage = 'Gagal mendapatkan lokasi: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking LBS'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 80, color: Colors.redAccent),
              const SizedBox(height: 20),
              Text(
                _locationMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _deteksiLokasi,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Lokasi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
