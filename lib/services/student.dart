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
