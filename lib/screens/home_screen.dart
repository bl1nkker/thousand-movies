import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thousand_movies/models/movie_model.dart';
import 'package:thousand_movies/network/movies_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? loading;
  bool? inErrorState;
  List<Movie> currentSearchList = [];
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState() {
          _page += 1;
        }

        print('Fetch data...');
        final result = await getMovieData(_page);
        currentSearchList.addAll(result);
      }
    });
  }

  Future<List<Movie>> getMovieData(int page) async {
    final moviesData = await MoviesService().getMovies(page);
    final moviesMap = json.decode(moviesData);
    return (moviesMap['results'] as List)
        .map((e) => Movie.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: FutureBuilder<List<Movie>>(
            future: getMovieData(1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),
                        textAlign: TextAlign.center, textScaleFactor: 1.3),
                  );
                }

                loading = false;
                final query = snapshot.data;
                inErrorState = false;
                if (query != null) {
                  currentSearchList = query;
                  return _buildMovieList(context, currentSearchList);
                } else {
                  return Container();
                }
              } else {
                return CircularProgressIndicator();
              }
              // TODO: Handle not done connection
            },
          ),
        ));
  }

  Widget _buildMovieList(BuildContext recipeListContext, List<Movie> movies) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width / 2;
    // 3
    return ListView.builder(
      controller: _scrollController,
      // 7
      itemCount: movies.length,
      // 8
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: movie.id,
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DetailsScreen(
            //               itemData: RE_DATA[index],
            //             )));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            margin: const EdgeInsets.only(bottom: 30.0),
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                // TODO: Work with colors
                color: Colors.greenAccent,
                image: DecorationImage(
                    image: NetworkImage(
                        'http://image.tmdb.org/t/p/w500/${movie.poster_path}'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(0, 5))
                ]),
            child: Stack(
              children: [
                Positioned(top: 0, right: 0, child: Text('123')),
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
                            backgroundColor: Colors.amber, color: Colors.black),
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
                        'Some anime name',
                        style: TextStyle(
                            backgroundColor: Colors.amber, color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
