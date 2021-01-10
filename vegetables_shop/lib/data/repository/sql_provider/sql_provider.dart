import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLProvider {
  SQLProvider._();
  static final SQLProvider db = SQLProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  factory SQLProvider() {
    return db;
  }

  Future<dynamic> initDB() async {
    var databasesPath = '/Users/yaroslavhalivets/Desktop/';
    var path = join(databasesPath, "vegatebles.db");

    // ByteData data = await rootBundle.load(join("assets", "vegatebles.db"));
    // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // await File(path).writeAsBytes(bytes);
    return await openDatabase(path);
  }
}
