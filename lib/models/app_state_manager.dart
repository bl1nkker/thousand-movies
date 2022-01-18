import 'package:flutter/material.dart';
import 'package:thousand_movies/models/movie_model.dart';

class AppStateManager extends ChangeNotifier {
  final _movieItems = <Movie>[];
  int _selectedIndex = -1;

  List<Movie> get groceryItems => List.unmodifiable(_movieItems);
  int get selectedIndex => _selectedIndex;
  Movie? get selectedMovieItem =>
      selectedIndex != -1 ? _movieItems[selectedIndex] : null;

  void setSelectedGroceryItem(String id) {
    final index = _movieItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    notifyListeners();
  }
}
