import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LBS extends StatefulWidget {
  const LBS({super.key});

  @override
  State<LBS> createState() => _LBSState();
}

class _LBSState extends State<LBS> {
  Position? _currentPosition;
  String _locationMessage = 'Menunggu lokasi...';
  GoogleMapController? _mapController;
  LatLng _initialCameraPosition = const LatLng(-6.200000, 106.816666); // Default Jakarta

  @override
  void initState() {
    super.initState();
    _deteksiLokasi();
  }

  Future<void> _deteksiLokasi() async {
    setState(() {
      _locationMessage = 'Menunggu lokasi...';
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Layanan lokasi tidak aktif';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
        _initialCameraPosition = LatLng(position.latitude, position.longitude);
      });

      // Pindahkan kamera ke lokasi baru
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_initialCameraPosition, 16),
      );
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: _currentPosition != null
                  ? {
                      Marker(
                        markerId: const MarkerId('lokasi_saya'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        infoWindow: const InfoWindow(title: 'Lokasi Saya'),
                      ),
                    }
                  : {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  _locationMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _deteksiLokasi,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Lokasi'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
