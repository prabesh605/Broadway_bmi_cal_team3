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
    final db = await instance.database;
    await db.insert('info', data.toJson());
  }
}
