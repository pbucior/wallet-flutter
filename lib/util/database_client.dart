import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/model/operation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableName = "operations";
  final String columnId = "id";
  final String columnDateAdded = "dateAdded";
  final String columnDateOperation = "dateOperation";
  final String columnAmount = "amount";
  final String columnDescription = "description";
  final String columnPostingKey = "postingKey";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "wallet.db");
    var walletDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return walletDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnDateAdded TEXT, $columnDateOperation TEXT, $columnAmount REAL, $columnDescription TEXT, $columnPostingKey TEXT)");
  }

  Future<int> saveItem(Operation operation) async {
    var dbClient = await db;
    int result = await dbClient.insert("$tableName", operation.toMap());
    return result;
  }

  Future<List> getOperations() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnDateAdded DESC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  Future<Operation> getOperation(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return new Operation.fromMap(result.first);
  }

  Future<int> deleteOperation(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateOperation(Operation operation) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", operation.toMap(),
        where: "$columnId = ?", whereArgs: [operation.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
