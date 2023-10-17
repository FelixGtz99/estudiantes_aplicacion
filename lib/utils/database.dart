import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/student.dart';

class DatabaseHelper {
  DatabaseHelper._(); // Constructor privado para Singleton
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  final String tableName = 'Students';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'students_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        student_id INTEGER PRIMARY KEY,
        last_name TEXT,
        middle_name TEXT,
        first_name TEXT,
        gender TEXT,
        created_on DATETIME,
        updated_on DATETIME
      )
    ''');
  }

  Future<int> insertStudent(StudentModel student) async {
    final db = await database;
    student.createdOn = DateTime.now();
    student.updatedOn = DateTime.now();
    return await db.insert(tableName, student.toJson());
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return StudentModel.fromJson(maps[index]);
    });
  }
}