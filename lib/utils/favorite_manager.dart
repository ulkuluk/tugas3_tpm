import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteManager {
  static const _key = 'favorite_items';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList(_key, favorites);
    }
  }

  static Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(id);
    await prefs.setStringList(_key, favorites);
  }

  static Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.contains(id);
  }
}
