import '../models/student.dart';

class StudentService {
  Future<List<StudentModel>> fetchStudents() async {
    // Simula una llamada al servidor
    await Future.delayed(Duration(seconds: 2)); // Simulando una demora de 2 segundos
    return List.generate(5, (index) {
      return StudentModel(
studentId: index,
        lastName: 'Apellido $index',
        middleName: 'Segundo Nombre $index',
        firstName: 'Nombre $index',
        gender: 'Género $index',
        updatedOn: DateTime.now(),
        createdOn: DateTime.now(),
      );
    });
  }
}
