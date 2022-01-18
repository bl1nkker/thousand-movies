import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thousand_movies/models/app_state_manager.dart';
import 'package:thousand_movies/navigation/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  await DotEnv.dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _appStateManager,
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: Router(
            backButtonDispatcher: RootBackButtonDispatcher(),
            routerDelegate: _appRouter,
          ),
          title: 'Thousand Movies',
        ));
  }
}
