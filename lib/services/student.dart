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
}
