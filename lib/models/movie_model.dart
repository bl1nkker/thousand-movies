import 'package:intl/intl.dart';

class Movie {
  final String id;
  final String original_title;
  final String overview;
  final String poster_path;
  final DateTime release_date;
  final double vote_average;
  final int vote_count;

  Movie({
    required this.id,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.vote_count,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json['id'].toString(),
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      release_date: DateFormat("yyyy-MM-dd").parse(json['release_date']),
      vote_average: json['vote_average'] / 1,
      vote_count: json['vote_count']);
}
