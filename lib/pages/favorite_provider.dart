import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final storedFavorites = prefs.getStringList('favorite_games') ?? [];
    _favorites.clear();
    _favorites.addAll(storedFavorites);
    notifyListeners();
  }

  Future<void> toggleFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();

    if (_favorites.contains(name)) {
      _favorites.remove(name);
    } else {
      _favorites.add(name);
    }

    await prefs.setStringList('favorite_games', _favorites);
    notifyListeners();
  }

  bool isFavorite(String name) {
    return _favorites.contains(name);
  }
}
