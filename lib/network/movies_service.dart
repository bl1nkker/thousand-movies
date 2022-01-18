import 'dart:convert';

import 'package:http/http.dart';
import 'package:thousand_movies/models/movie_model.dart';

class RecipeService {
  Future getData(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getMovies(String query, int page) async {
    final moviesData = await getData(
        'https://api.themoviedb.org/3/movie/popular?api_key=64dd5fbe2a0241ba5b8c174482243af2&language=en-US&page=$page');
    final moviesMap = json.decode(moviesData);
    return Movie.fromJson(moviesMap);
  }
}
