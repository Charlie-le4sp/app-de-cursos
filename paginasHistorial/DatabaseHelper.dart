import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'visited_pages';
  static const String columnId = 'id';
  static const String columnPageName = 'pageName';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  String _tableName = 'visited_pages';

  Future<void> deleteAllPages() async {
    final db = await database;
    await db.delete(_tableName);
  }

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'visited_pages.db');
    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnPageName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertVisitedPage(String pageName) async {
    final db = await database;
    return db.insert(tableName, {
      columnPageName: pageName,
    });
  }

  Future<List<String>> getVisitedPages() async {
    final db = await database;
    final result = await db.query(tableName);
    final pages = <String>[];
    for (final row in result) {
      pages.add(row[columnPageName] as String);
    }
    return pages;
  }
}
