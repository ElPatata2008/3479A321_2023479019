import 'package:lab3/entity/actividad.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activity_database.db');

    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate,  
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE [Actividad] (
        [id] INTEGER PRIMARY KEY,
        [fecha] TEXT NOT NULL,
        [nombre] TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertActividad(Actividad actividad) async {
    final db = await database;
    await db.insert(
      'Actividad', 
      actividad.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}