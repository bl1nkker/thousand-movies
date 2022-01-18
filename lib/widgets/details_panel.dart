import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thousand_movies/models/movie_model.dart';

class DetailsPanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final Movie movie;
  const DetailsPanelWidget(
      {Key? key,
      required this.controller,
      required this.panelController,
      required this.movie})
      : super(key: key);

  void togglePanel() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return ClipRRect(
      // borderRadius: BorderRadius.circular(30),
      child: Container(
          height: MediaQuery.of(context).size.height * .3,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(1),
                // Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.6),
              ])),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movie.original_title,
                      style: TextStyle(color: Colors.amber, fontSize: 24),
                    ),
                  ),
                  RatingBarWidget(
                    rating: movie.vote_average / 2,
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Text(movie.overview,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  final double rating;
  const RatingBarWidget({Key? key, required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RatingBar(
          initialRating: rating,
          itemSize: 24,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          ratingWidget: RatingWidget(
            full: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            half: Icon(
              Icons.star_half,
              color: Colors.amber,
            ),
            empty: Icon(
              Icons.star_border,
              color: Colors.amber,
            ),
          ),
          onRatingUpdate: (newRaiting) {}),
    );
  }
}
