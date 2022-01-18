import 'package:flutter/material.dart';
import 'package:thousand_movies/models/app_state_manager.dart';
import 'package:thousand_movies/screens/details_screen.dart';
import 'package:thousand_movies/screens/home_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // Declares pages, the stack of pages that describes your navigation stack
      pages: [
        if (appStateManager.selectedIndex == -1)
          HomeScreen.page()
        else
          DetailsScreen.page(
              movie: appStateManager.selectedMovieItem,
              index: appStateManager.selectedIndex)
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
