import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper2 {
  static Database? _database2;
  static const String tableName2 = 'visited_pages2';
  static const String columnid2 = 'id2';
  static const String columnpageName2 = 'pageName2';

  Future<Database> get database async {
    if (_database2 != null) {
      return _database2!;
    }

    _database2 = await initializeDatabase2();
    return _database2!;
  }

  String _tableName2 = 'visited_pages2';

  Future<void> deleteAllpages2() async {
    final db2 = await database;
    await db2.delete(_tableName2);
  }

  Future<void> deleteLastVisitedPage3() async {
    final db2 = await database;
    final result = await db2.query(
      _tableName2,
      orderBy: '$columnid2 DESC',
      limit: 1,
    );
    if (result.isNotEmpty) {
      final lastPage = result.first;
      final lastPageId = lastPage[columnid2] as int;
      await db2.delete(
        _tableName2,
        where: '$columnid2 = ?',
        whereArgs: [lastPageId],
      );
    }
  }

  Future<Database> initializeDatabase2() async {
    final path2 = await getDatabasesPath();
    final databasePath2 = join(path2, 'visited_pages2.db2');
    return openDatabase(
      databasePath2,
      onCreate: (db2, version) {
        return db2.execute(
          'CREATE TABLE $tableName2($columnid2 INTEGER PRIMARY KEY AUTOINCREMENT, $columnpageName2 TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertVisitedPage2(String pageName2) async {
    final db2 = await database;
    return db2.insert(tableName2, {
      columnpageName2: pageName2,
    });
  }

  Future<List<String>> getVisitedpages2() async {
    final db2 = await database;
    final result2 = await db2.query(tableName2);
    final pages2 = <String>[];
    for (final row in result2) {
      pages2.add(row[columnpageName2] as String);
    }
    return pages2;
  }
}
