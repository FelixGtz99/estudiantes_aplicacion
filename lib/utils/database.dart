import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/address.dart';
import '../models/email.dart';
import '../models/phone.dart';
import '../models/student.dart';

class DatabaseHelper {
  DatabaseHelper._();
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
    final path = join(await getDatabasesPath(), 'students_database5.db');
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
        status INTEGER DEFAULT 1,
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
    final List<Map<String, dynamic>> maps = await db.query(studentsTableName,where:'status = ?', whereArgs: [1] );
    return List.generate(maps.length, (index) {
      return StudentModel.fromJson(maps[index]);
    });
  }
Future<int> deleteStudent(int studentId) async {
  final db = await database;
  final student = {
    'status': 0,
    'updated_on': DateTime.now().toIso8601String(),
  };

  return await db.update(
    studentsTableName,
    student,
    where: 'student_id = ?',
    whereArgs: [studentId],
  );
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
Future<int> updateStudent(StudentModel student) async {
  final db = await database;
  student.updatedOn = DateTime.now();
  return await db.update(
    studentsTableName,
    student.toJson(),
    where: 'student_id = ?',
    whereArgs: [student.studentId],
  );
}

Future<int> updateAddress(AddressModel address) async {
  final db = await database;
  address.updatedOn = DateTime.now();
  return await db.update(
    addressTableName,
    address.toJson(),
    where: 'address_id = ?',
    whereArgs: [address.addressId],
  );
}
Future<int> updateEmail(EmailModel email) async {
  final db = await database;
  email.updatedOn = DateTime.now();
  return await db.update(
    emailsTableName,
    email.toJson(),
    where: 'email = ?',
    whereArgs: [email.email],
  );
}
Future<int> updatePhone(PhoneModel phone) async {
  final db = await database;
  phone.updatedOn = DateTime.now();
  return await db.update(
    phonesTableName,
    phone.toJson(),
    where: 'phone_id = ?',
    whereArgs: [phone.phoneId],
  );
}
  Future<EmailModel> getEmail(String email) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
   emailsTableName,
    where: 'email = ?',
    whereArgs: [email],
  );
  if (maps.isNotEmpty) {
    return EmailModel.fromJson(maps.first);
  } else {
    throw Exception('Correo no encontrado');
  }
}
  Future<PhoneModel> getPhone(int phoneId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
   phonesTableName,
    where: 'phone_id = ?',
    whereArgs: [phoneId],
  );
  if (maps.isNotEmpty) {
    return PhoneModel.fromJson(maps.first);
  } else {
    throw Exception('Teléfono no encontrado');
  }
}

  Future<AddressModel> getAddress(int addressId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
  addressTableName,
    where: 'address_id = ?',
    whereArgs: [addressId],
  );
  if (maps.isNotEmpty) {
    return AddressModel.fromJson(maps.first);
  } else {
    throw Exception('Dirección no encontrada');
  }
}
Future<int> deletePhone(int phoneId) async {
  final db = await database;
  return await db.delete(
    phonesTableName,
    where: 'phone_id = ?',
    whereArgs: [phoneId],
  );
}
Future<int> deleteAddress(int addressId) async {
  final db = await database;
  return await db.delete(
    addressTableName,
    where: 'address_id = ?',
    whereArgs: [addressId],
  );
}
Future<int> deleteEmail(String email) async {
  final db = await database;
  return await db.delete(
    emailsTableName,
    where: 'email = ?',
    whereArgs: [email],
  );
}
}