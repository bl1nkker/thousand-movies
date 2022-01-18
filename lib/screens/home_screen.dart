import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thousand_movies/models/app_state_manager.dart';
import 'package:thousand_movies/models/movie_model.dart';
import 'package:thousand_movies/network/movies_service.dart';

class HomeScreen extends StatefulWidget {
  static MaterialPage page({
    Movie? movie,
    int index = -1,
  }) {
    return MaterialPage(
      child: HomeScreen(),
    );
  }

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  bool? inErrorState;
  List<Movie> currentSearchList = [];
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<AppStateManager>(context, listen: false).getMovieItems();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        loading = true;
        _page += 1;
        await Provider.of<AppStateManager>(context, listen: false)
            .updateMovieItems(_page);
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Consumer<AppStateManager>(
            builder: (context, manager, child) {
              if (manager.moviesItems.isNotEmpty) {
                return Container(
                  child: _buildMovieList(context, manager.moviesItems),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  Widget _buildMovieList(BuildContext recipeListContext, List<Movie> movies) {
    // 3
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      // 7
      itemCount: movies.length,
      // 8
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(
          movie: movies[index],
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 250.0;
    final itemWidth = size.width / 2;
    return Hero(
        tag: movie.id,
        child: GestureDetector(
          onTap: () {
            Provider.of<AppStateManager>(context, listen: false)
                .setSelectedMovieItem(movie.id);
          },
          child: CachedNetworkImage(
            imageUrl: 'http://image.tmdb.org/t/p/w500/${movie.poster_path}',
            imageBuilder: (context, imageProvider) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(bottom: 30.0),
              height: itemHeight,
              width: itemWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  // TODO: Work with colors
                  color: Colors.greenAccent,
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // TODO: Work with colors
                        // color: COLOR_GREY,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          movie.original_title,
                          style: TextStyle(
                              backgroundColor: Colors.amber,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        // TODO: Work with colors
                        // color: COLOR_BLACK,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          DateFormat("yMMMMd").format(movie.release_date),
                          style: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
