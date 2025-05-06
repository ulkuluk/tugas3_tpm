import 'package:flutter/material.dart';
import 'package:tugas3_tpm/models/game_store.dart';
import 'package:tugas3_tpm/pages/detail_store.dart';
import 'package:tugas3_tpm/models/cart_model.dart';
import 'package:tugas3_tpm/pages/cart_page.dart';

class SiteRecomendationList extends StatefulWidget {
  const SiteRecomendationList({super.key});

  @override
  State<SiteRecomendationList> createState() => _SiteRecomendationListState();
}

class _SiteRecomendationListState extends State<SiteRecomendationList> {
  late List<bool> isFavoriteList;

  @override
  void initState() {
    super.initState();
    _syncFavorites();
  }

  void _syncFavorites() {
    isFavoriteList = List<bool>.generate(
      gameList.length,
      (index) => CartModel.contains(gameList[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Game Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
              setState(() {
                _syncFavorites(); // Update status tombol chart setelah kembali
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder:
            (BuildContext context, int index) => _gameStore(context, index),
        itemCount: gameList.length,
      ),
    );
  }

  Widget _gameStore(BuildContext context, int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailPage(index: index)),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    gameList[index].imageUrls[0],
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameList[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${gameList[index].reviewAverage.toString()} | ${gameList[index].reviewCount.toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${gameList[index].price.toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index];
                    if (isFavoriteList[index]) {
                      CartModel.add(gameList[index]);
                    } else {
                      CartModel.remove(gameList[index]);
                    }
                  });
                },
                icon: Icon(
                  isFavoriteList[index] ? Icons.favorite : Icons.favorite,
                  color: isFavoriteList[index] ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
