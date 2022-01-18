import 'package:thousand_movies/models/genre_model.dart';

class Movie {
  final String original_title;
  final String overview;
  final DateTime release_date;
  final double vote_average;
  final double vote_count;
  final List<Genre> genres;

  Movie({
    required this.original_title,
    required this.overview,
    required this.release_date,
    required this.vote_average,
    required this.vote_count,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      original_title: json['original_title'],
      overview: json['overview'],
      release_date: json['release_date'],
      vote_average: json['vote_average'],
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      vote_count: json['vote_count']);
}
