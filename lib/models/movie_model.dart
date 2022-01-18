import 'package:intl/intl.dart';

// Table name is database
final String tableMovies = 'movies';

// Fields in the table
class MovieFields {
  static final List<String> values = [
    // Add all fields
    id, original_title, overview, poster_path, release_date, vote_average,
    vote_count
  ];
  static const String id = '_id';
  static const String original_title = 'original_title';
  static const String overview = 'overview';
  static const String poster_path = 'poster_path';
  static const String release_date = 'release_date';
  static const String vote_average = 'vote_average';
  static const String vote_count = 'vote_count';
}

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

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.original_title: original_title,
        MovieFields.overview: overview,
        MovieFields.poster_path: poster_path,
        MovieFields.release_date: release_date.toIso8601String(),
        MovieFields.vote_average: vote_average,
        MovieFields.vote_count: vote_count,
      };
}
