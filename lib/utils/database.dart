import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/address.dart';
import '../models/email.dart';
import '../models/phone.dart';
import '../models/student.dart';

class DatabaseHelper {
  DatabaseHelper._(); // Constructor privado para Singleton
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  final String studentsTableName = 'Students';
  final String addressTableName = 'Address';
  final String phonesTableName = 'Phones';
  final String emailsTableName = 'Emails';



  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'students_database.db');
    return await openDatabase(path, version: 2, onCreate: _createDatabase);
  }

 Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $studentsTableName(
        student_id INTEGER PRIMARY KEY,
        last_name TEXT,
        middle_name TEXT,
        first_name TEXT,
        gender TEXT,
        created_on DATETIME,
        updated_on DATETIME
      )
    ''');

    await db.execute('''
      CREATE TABLE $addressTableName(
        address_id INTEGER PRIMARY KEY,
        student_id INTEGER,
        address_line TEXT,
        city TEXT,
        zip_postcode TEXT,
        state TEXT,
        created_on DATETIME,
        updated_on DATETIME,
        FOREIGN KEY (student_id) REFERENCES $studentsTableName(student_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE $emailsTableName(
        student_id INTEGER,
        email TEXT,
        email_type TEXT,
        created_on DATETIME,
        updated_on DATETIME,
        FOREIGN KEY (student_id) REFERENCES $studentsTableName(student_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE $phonesTableName(
        phone_id INTEGER PRIMARY KEY,
        student_id INTEGER,
        phone TEXT,
        country_code TEXT,
        area_code TEXT,
        phone_type TEXT,
        created_on DATETIME,
        updated_on DATETIME,
        FOREIGN KEY (student_id) REFERENCES $studentsTableName(student_id)
      )
    ''');
  }

  Future<int> insertStudent(StudentModel student) async {
    final db = await database;
    student.createdOn = DateTime.now();
    student.updatedOn = DateTime.now();
    return await db.insert(studentsTableName, student.toJson());
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(studentsTableName);
    return List.generate(maps.length, (index) {
      return StudentModel.fromJson(maps[index]);
    });
  }

  Future<List<EmailModel>> getEmailsByStudentId(int studentId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    emailsTableName,
    where: 'student_id = ?',
    whereArgs: [studentId],
  );

  return List.generate(maps.length, (index) {
    return EmailModel.fromJson(maps[index]);
  });
}

Future<int> insertEmail(EmailModel email) async {
  final db = await database;
  email.createdOn = DateTime.now();
  email.updatedOn = DateTime.now();
  return await db.insert(emailsTableName, email.toJson());
}
Future<List<PhoneModel>> getPhonesByStudentId(int studentId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    phonesTableName,
    where: 'student_id = ?',
    whereArgs: [studentId],
  );

  return List.generate(maps.length, (index) {
    return PhoneModel.fromJson(maps[index]);
  });
}

Future<int> insertPhone(PhoneModel phone) async {
  final db = await database;
  phone.createdOn = DateTime.now();
  phone.updatedOn = DateTime.now();
  return await db.insert(phonesTableName, phone.toJson());
}
Future<List<AddressModel>> getAddressesByStudentId(int studentId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    addressTableName,
    where: 'student_id = ?',
    whereArgs: [studentId],
  );

  return List.generate(maps.length, (index) {
    return AddressModel.fromJson(maps[index]);
  });
}
Future<int> insertAddress(AddressModel address) async {
  final db = await database;
  address.createdOn = DateTime.now();
  address.updatedOn = DateTime.now();
  return await db.insert(addressTableName, address.toJson());
}
}