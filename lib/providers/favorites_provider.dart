import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<int> _favorites = [];

  List<int> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favorites.contains(id);
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites =
        prefs.getStringList('favorites')?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favorites',
      _favorites.map((e) => e.toString()).toList(),
    );
  }
}
