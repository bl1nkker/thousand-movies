import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thousand_movies/models/movie_model.dart';

class MoviesDatabase {
  static final MoviesDatabase instance = MoviesDatabase._init();

  static Database? _database;

  MoviesDatabase._init();

  // Getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("Movies.db");
    return _database!;
  }

  // Open database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'FLOAT';
    const intType = 'INTEGER';

    // Create table
    await db.execute('''
    CREATE TABLE $tableMovies (
      ${MovieFields.id} $idType,
      ${MovieFields.original_title} $textType,
      ${MovieFields.overview} $textType,
      ${MovieFields.poster_path} $textType,
      ${MovieFields.release_date} $textType,
      ${MovieFields.vote_average} $doubleType,
      ${MovieFields.vote_count} $intType
    )
    ''');
  }

  void addMoviesToDb(List<Movie> movies) async {
    final db = await instance.database;
    Batch batch = db.batch();
    for (Movie movie in movies) {
      batch.insert(tableMovies, movie.toJson());
    }

    await batch.commit(noResult: true);
  }

  // Read all Movies
  Future<List<Movie>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableMovies);
    return result.map((jsonMovie) => Movie.fromJson(jsonMovie)).toList();
  }

  // Close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
