import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tugas3_tpm/models/cart_model.dart';
import 'package:tugas3_tpm/models/game_store.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getStringList('cart_items') ?? [];
    final restored =
        savedCart.map((e) => GameStore.fromJson(jsonDecode(e))).toList();
    setState(() {
      CartModel.replaceAll(restored);
    });
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson =
        CartModel.items.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('cart_items', cartJson);
  }

  void _removeItem(GameStore game) {
    setState(() {
      CartModel.remove(game);
    });
    _saveCart();
  }

  @override
  void dispose() {
    _saveCart();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = CartModel.items;

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Site")),
      body:
          items.isEmpty
              ? Center(child: Text("Daftar Favorite masih kosong"))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final game = items[index];
                  return ListTile(
                    leading: Image.network(
                      game.imageUrls[0],
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(game.name),
                    subtitle: Text('Harga: \$${game.price.toString()}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(game);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${game.name} dihapus dari favorite"),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
