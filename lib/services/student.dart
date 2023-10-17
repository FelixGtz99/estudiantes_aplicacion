import 'package:estudiantes_aplicacion/models/email.dart';

import '../utils/database.dart';

import '../models/student.dart';
class StudentService {
      final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  Future<List<StudentModel>> fetchStudents() async {
    // Simula una llamada al servidor
   return await databaseHelper.getAllStudents();
  }



  Future<int> addStudent(StudentModel student) async {
    return await databaseHelper.insertStudent(student);
  }
    Future<int> editStudent(StudentModel student) async {
    return await databaseHelper.updateStudent(student);
  }

  Future<int> addEmail(EmailModel email) async {
    return await databaseHelper.insertEmail(email);
  }
  Future<int> editEmail(EmailModel email) async {
    return await databaseHelper.updateEmail(email);
  }

  Future<List<EmailModel>> getEmail(studentId) async{
    return await databaseHelper.getEmailsByStudentId(studentId);
  }
    Future<EmailModel> getDataEmail(email) async{
    return await databaseHelper.getEmail(email);
  }
  Future<StudentModel> getStudentById(int studentId) async {
  final db = await databaseHelper.database;
  final List<Map<String, dynamic>> maps = await db.query(
   'Students',
    where: 'student_id = ?',
    whereArgs: [studentId],
  );
  if (maps.isNotEmpty) {
    return StudentModel.fromJson(maps.first);
  } else {
    throw Exception('Estudiante no encontrado');
  }
}
}
