import 'dart:convert';

import 'package:http/http.dart';
import 'package:thousand_movies/models/movie_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class MoviesService {
  Future getData(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getMovies(int page) async {
    final moviesData = await getData(
        'https://api.themoviedb.org/3/movie/popular?api_key=${DotEnv.dotenv.env['API_KEY']}&language=en-US&page=$page');
    final moviesMap = json.decode(moviesData);
    return (moviesMap['results'] as List)
        .map((e) => Movie.fromJson(e))
        .toList();
  }
}
