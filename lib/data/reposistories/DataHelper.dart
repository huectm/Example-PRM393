import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Datahelper
{
  static final Datahelper instance = Datahelper();
  Future<Database>? _database;
  Future<void> _createTables(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS CartItems (
      proId INTEGER PRIMARY KEY,
      quantity INTEGER NOT NULL DEFAULT 1,
      isSelected INTEGER NOT NULL DEFAULT 1
    )
  ''');
  }

  Future<Database> get database async{
    _database??= _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shopping.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {await _createTables(db);},
      onCreate: (db, version) async {await _createTables(db);}
    );
  }
}