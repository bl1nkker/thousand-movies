import 'package:flutter/material.dart';
import 'package:thousand_movies/models/movie_model.dart';

class DetailsScreen extends StatelessWidget {
  static MaterialPage page({
    Movie? movie,
    int index = -1,
  }) {
    return MaterialPage(
      child: DetailsScreen(
        movie: movie,
      ),
    );
  }

  final Movie? movie;
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(movie!.original_title),
    );
  }
}
