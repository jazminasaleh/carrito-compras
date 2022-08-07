import 'dart:async';

import 'package:carro_comprasa/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ShopDatabase {
  static final ShopDatabase instance = ShopDatabase._init();

  static Database? _database;

  ShopDatabase._init();

  final String tableCartItems = 'cart_items';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('shop.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  FutureOr _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableCartItems(
    id INTEGER PRIMARY KEY,
    name TEXT,
    price INTEGER,
    quantity INTEGER
    )
    ''');
  }

   Future<void> insert(CartItem item) async {
    final db = await instance.database;
    await db.insert(tableCartItems, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
