import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas3_tpm/pages/LBS.dart';
import 'package:tugas3_tpm/pages/login.dart';
import 'package:tugas3_tpm/pages/stopwatch.dart';
import 'package:tugas3_tpm/pages/bilangan.dart';
import 'package:tugas3_tpm/pages/konversi.dart';
import 'package:tugas3_tpm/pages/recomendation_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HalamanUtama(),
    const DaftarAnggota(),
    const MenuBantuan(),
  ];

  final List<String> _titles = ['Halaman Utama', 'Daftar Anggota', 'Bantuan'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions:
            _selectedIndex == 0
                ? [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    tooltip: 'Logout',
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('isLoggedIn');
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ]
                : null,
      ),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Utama'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Anggota'),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Stopwatch', 'icon': Icons.timer},
      {'title': 'Jenis Bilangan', 'icon': Icons.calculate},
      {'title': 'Tracking LBS', 'icon': Icons.location_on},
      {'title': 'Konversi Waktu', 'icon': Icons.access_time},
      {'title': 'Rekomendasi Situs', 'icon': Icons.web},
      // {'title': 'Favorite Gamestore List', 'icon': Icons.favorite},
    ];

    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                menuItems.map((menu) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: InkWell(
                      
                      onTap: () {
                        if (menu['title'] == 'Stopwatch') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StopwatchPage(),
                            ),
                          );
                        } else if (menu['title'] == 'Jenis Bilangan') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const checkNumberType(),
                            ),
                          );
                        } else if (menu['title'] == 'Tracking LBS') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LBS(),
                            ),
                          );
                        } else if (menu['title'] == 'Konversi Waktu') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeConversionPage(),
                            ),
                          );
                        } else if (menu['title'] == 'Rekomendasi Situs') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const SiteRecomendationList(),
                            ),
                          );
                        }
                        // else if (menu['title'] == 'Favorite Gamestore List') {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const FavoriteListPage(),
                        //     ),
                        //   );
                        // }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Menu "${menu['title']}" belum tersedia',
                              ),
                              backgroundColor: Colors.orangeAccent,
                            ),
                          );
                        }
                      },
                      child: Card(
                        
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                menu['icon'],
                                size: 40,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                menu['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class DaftarAnggota extends StatelessWidget {
  const DaftarAnggota({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> anggota = [
      {'nama': 'Muhammad Alfi Ramadhan | 123220179', 'foto': 'img/alfi.jpg'},
      {'nama': 'Farizal Septin Efendi | 123220199', 'foto': 'img/rijal.jpg'},
      {'nama': 'Dewangga Mukti Wibawa | 123220208', 'foto': 'img/dwg.jpg'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: anggota.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            leading: Container(
              padding: const EdgeInsets.all(2), 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(anggota[index]['foto']!),
                radius: 24,
              ),
            ),
            title: Text(
              anggota[index]['nama']!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}

class MenuBantuan extends StatelessWidget {
  const MenuBantuan({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Panduan Penggunaan Aplikasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '📌 Stopwatch:\n- Tekan "start" untuk memulai waktu.\n- Gunakan "stop" untuk menghentikan sementara.\n- Tekan "Reset" untuk mengatur ulang.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 12),
                Text(
                  '📌 Jenis Bilangan:\n- Masukkan angka untuk mengetahui apakah itu ganjil, genap, positif, negatif, atau nol.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 12),
                Text(
                  '📌 Konversi Waktu:\n- Masukk jumlah tahun untuk dikonversi ke hari, jam, dan menit.\n- Contoh: 1 tahun = 365 hari = 8.760 jam = 525.600 menit.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 12),
                Text(
                  '📌 LBS:\n- Tekan Tombol Untuk Mengetahui Lokasimu Sekarang',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 12),
                Text(
                  '📌 Rekomendasi Situs:tekan card untuk melihat detail item, kemudian takan tombol (go to webstore) untuk menuju kesitus. \n- tekan tombol "love" untuk menambahkan item ke favorit',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 24),
                Text(
                  'Jika mengalami kendala, silakan hubungi tim pengembang melalui email:\n\nsupport@contoh.com',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
