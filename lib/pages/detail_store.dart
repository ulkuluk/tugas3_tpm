import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas3_tpm/models/game_store.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final int index;
  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // loadFavoriteStatus();
  }

  // Future<void> loadFavoriteStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favorites = prefs.getStringList('favorite_games') ?? [];
  //   final id = gameList[widget.index].name;
  //   setState(() {
  //     isFavorite = favorites.contains(id);
  //   });
  // }

  // Future<void> toggleFavorite() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favorites = prefs.getStringList('favorite_games') ?? [];
  //   final id = gameList[widget.index].name;

  //   if (isFavorite) {
  //     favorites.remove(id);
  //   } else {
  //     favorites.add(id);
  //   }

  //   await prefs.setStringList('favorite_games', favorites);
  //   setState(() {
  //     isFavorite = !isFavorite;
  //   });

  //   Navigator.pop(
  //     context,
  //     true,
  //   ); // <- Ini mengirim sinyal ke halaman sebelumnya
  // }

  @override
  Widget build(BuildContext context) {
    final game = gameList[widget.index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       isFavorite ? Icons.favorite : Icons.favorite_border,
        //       color: Colors.red,
        //     ),
        //     onPressed: toggleFavorite,
        //   ),
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              game.imageUrls[0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                game.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                game.price,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${game.reviewAverage} | ${game.reviewCount} Reviews',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  infoTile('Warna', game.releaseDate),
                  infoTile(
                    'Vaksin',
                    game.tags.isNotEmpty ? game.tags.join(", ") : "Tidak ada",
                  ),
                  infoTile('Latar Belakang', game.about),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color.fromARGB(255, 95, 93, 92),
            ),
            onPressed: () async {
              await launchUrl(Uri.parse(game.linkStore));
            },
            child: Text(
              'Go To Website',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
