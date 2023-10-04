import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _getDatabase() async {
    final String path = await getDatabasesPath();
    final localDataBase = join(path, 'base.db');

    return await openDatabase(
      localDataBase,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, age INTEGER)'
        );
      },
    );
  }

  _addUser() async {
    Database db = await _getDatabase();
    int result = await db.insert(
      'users',
      {
        'name':  'Diogo',
        'age': 31
      }
    );
    print( result );
    return result;
  }

  Future<List> _listUsers() async {
    Database db = await _getDatabase();
    List users = await db.rawQuery(
      'SELECT * FROM users'
    );
    print(users);
    return users;
  }

  _removeUser(int userID) async {
    Database db = await _getDatabase();
    db.rawDelete(
      'DELETE FROM users WHERE id = ?',
      [userID]
    );
  }

  @override
  Widget build(BuildContext context) {
    // _addUser();
    _removeUser(8);
    print( _listUsers() );
    return const Placeholder();
  }
}