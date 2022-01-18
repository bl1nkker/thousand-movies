import 'package:flutter/material.dart';
import 'package:thousand_movies/db/movies_database.dart';
import 'package:thousand_movies/models/movie_model.dart';
import 'package:thousand_movies/network/movies_service.dart';

class AppStateManager extends ChangeNotifier {
  List<Movie> _movieItems = <Movie>[];
  int _selectedIndex = -1;

  List<Movie> get moviesItems => List.unmodifiable(_movieItems);
  int get selectedIndex => _selectedIndex;
  Movie? get selectedMovieItem =>
      selectedIndex != -1 ? _movieItems[selectedIndex] : null;
  void retrieveToDos() async {
    notifyListeners();
  }

  Future getMovieItems() async {
    // Check SQFLITE here
    final _dbMovies = await MoviesDatabase.instance.readAll();
    if (_dbMovies.isEmpty) {
      final movies = await MoviesService().getMovies(1);
      _movieItems = movies;
      MoviesDatabase.instance.addMoviesToDb(movies);
    } else {
      print('Data from database');
      _movieItems = _dbMovies;
    }
    notifyListeners();
  }

  Future updateMovieItems(int page) async {
    final movies = await MoviesService().getMovies(page);
    print('Data loaded');
    _movieItems.addAll(movies);
    notifyListeners();
  }

  void setSelectedMovieItem(String id) {
    final index = _movieItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    notifyListeners();
  }
}
