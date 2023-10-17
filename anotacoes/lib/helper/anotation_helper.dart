import 'package:anotacoes/model/anotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotationHelper {
  static final AnotationHelper _instance = AnotationHelper._internal();
  final String tableName = 'anotations';
  Database? _db;

  factory AnotationHelper() {
    return _instance;
  }

  AnotationHelper._internal();

  Future<Database> get db async {
    return _db ?? await _initDatabase();
  }

  void _onCreate( Database db, int version ) async {
    await db.execute(
      'CREATE TABLE $tableName ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title VARCHAR,'
        'description TEXT,'
        'createData DATETIME )'
    );
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final localDatabase = join( path, 'anotations.db' );

    Database db = await openDatabase(
      localDatabase,
      version: 1,
      onCreate: _onCreate
    );
    return db;
  }

  Future<int> saveAnotation( Anotation anotation) async {
    Database database = await db;
    return await database.insert(
      tableName, 
      anotation.toMap()
    );
  }

   Future<int> updateAnotation( Anotation anotation) async {
    Database database = await db;
    print(anotation.id);
    return await database.update(
      tableName, 
      anotation.toMap(),
      where: 'id = ?',
      whereArgs: [anotation.id]
    );
  }

  Future<List> getAnotations() async {
    Database database = await db;
    return database.rawQuery(
      'SELECT * FROM $tableName ORDER BY createData DESC'
    );
  }

  Future<int> removeAnotation(int id) async {
    Database database = await db;
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}