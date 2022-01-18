import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thousand_movies/models/app_state_manager.dart';
import 'package:thousand_movies/models/movie_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thousand_movies/widgets/details_panel.dart';

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
    final PanelController panelController = PanelController();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
            controller: panelController,
            // backdropColor: Colors.red.withAlpha(1),
            color: Colors.transparent,
            minHeight: 200,
            maxHeight: 300,
            parallaxEnabled: true,
            parallaxOffset: .1,
            panelBuilder: (controller) => DetailsPanelWidget(
                controller: controller,
                panelController: panelController,
                movie: movie!),
            body: CachedNetworkImage(
              imageUrl: 'http://image.tmdb.org/t/p/w500/${movie!.poster_path}',
              imageBuilder: (context, imageProvider) => Container(
                  // TODO: Change content padding value to constant

                  height: 250,
                  decoration: BoxDecoration(
                    // TODO: Set default image color
                    color: Colors.greenAccent,
                    image: DecorationImage(
                        image: imageProvider,
                        // alignment: Alignment(-.7, 0),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<AppStateManager>(context,
                                          listen: false)
                                      .setSelectedMovieItem('');
                                },
                                child: const Icon(Icons.arrow_back_ios_sharp,
                                    // TODO: Work with colors
                                    color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}
