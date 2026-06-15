import 'package:broadway_bmi_cal/offline/info_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineService {
  static final OfflineService instance = OfflineService._initDB();
  static Database? _database;
  OfflineService._initDB();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("offline.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
    Create Table info(
    id INTEGER primary key autoincrement,
    name text ,
    address text
    )
    ''');
  }

  Map<String, dynamic> data = {"name": "Prabesh", "address": "ktm"};
  //insert
  Future<void> insert(Info data) async {
    try {
      final db = await instance.database;
      await db.insert('info', data.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  //get
  Future<List<Info>> get() async {
    try {
      final db = await instance.database;
      List<Map<String, dynamic>> value = await db.query('info');

      List<Info> data = value.map((item) => Info.fromJson(item)).toList();
      return data;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete('info', where: "id=?", whereArgs: [id]);
    } catch (e) {
      throw e.toString();
    }
  }

  //update
  Future<void> update(Info info) async {
    try {
      final db = await instance.database;
      await db.update(
        'info',
        info.toJson(),
        where: "id=?",
        whereArgs: [info.id],
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
