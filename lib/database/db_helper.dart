import 'package:flutter_contact/model/daftar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnnotelp = 'notelp';
  final String columnPeminjaman = 'Tanggal_Peminjaman';
  final String columnPengembalian = 'tanggal_pengembalian';
  final String columnJaminan = 'jaminan';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    //  var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
    //      "$columnNama TEXT,"
    //      "$columnnotelp TEXT,"
    //      "$columnEmail TEXT,"
    //      "$columnCompany TEXT)";
     await db.execute(
      '''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY NOT NULL,
        $columnNama TEXT,
        $columnnotelp TEXT,
        $columnPeminjaman TEXT,
        $columnPengembalian TEXT,
        $columnJaminan TEXT)
      '''
     );
  }

  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(tableName);
    return queryResult.map((e) => Kontak.fromMap(e)).toList();
  }

  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(), where: '$columnId = ?', whereArgs: [kontak.id]);
  }

  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}