import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Datahelper1
{
  static final  instal=Datahelper1();
  Future<Database>? _dataBase;
  Future<Database> get database async
  {
    return _dataBase??_initData();
  }
  Future<Database> _initData() async
  {
    var path= join(await getDatabasesPath(),'ShoppingCart.db');
    return await
      openDatabase(
        path,
        version: 1,
        onCreate: (db,v)
        {
          return db.execute(
              '''CREATE TABLE  CartItems (
              proId INTEGER PRIMARY KEY,
              quantity INTEGER NOT NULL DEFAULT 1,
              isSelected INTEGER NOT NULL DEFAULT 1'''
          );});

        }
  }

