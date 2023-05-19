import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/investment.dart';

class DatabaseHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String TICKER = 'ticker';
  static const String PRICE_BUY = 'priceBuy';
  static const String PRICE_SALE = 'priceSale';
  static const String TABLE = 'Investment';
  static const String DB_NAME = 'investments.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TICKER TEXT, $PRICE_BUY REAL, $PRICE_SALE REAL)");
  }

  Future<Investment> save(Investment investment) async {
    var dbClient = await db;
    if (dbClient != null) {
      investment.id = await dbClient.insert(TABLE, investment.toMap());
    }
    return investment;
  }

  Future<List<Investment>> getInvestments() async {
    var dbClient = await db;
    List<Investment> investments = [];
    if (dbClient != null) {
      List<Map<String, dynamic>> maps = await dbClient.query(TABLE, columns: [
        ID,
        TICKER,
        PRICE_BUY,
        PRICE_SALE,
      ]);
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          investments.add(Investment.fromMap(maps[i]));
        }
      }
    }
    return investments;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    if (dbClient != null) {
      return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
    }
    return 0;
  }

  Future<int> update(Investment investment) async {
    var dbClient = await db;
    if (dbClient != null) {
      return await dbClient.update(TABLE, investment.toMap(),
          where: '$ID = ?', whereArgs: [investment.id]);
    }
    return 0;
  }

  Future close() async {
    var dbClient = await db;
    if (dbClient != null) {
      dbClient.close();
    }
  }
}
