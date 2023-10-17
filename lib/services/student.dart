import 'package:estudiantes_aplicacion/models/address.dart';
import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/views/add_phone.dart';

import '../models/phone.dart';
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

  
  Future<int> addPhone(PhoneModel phone) async {
    return await databaseHelper.insertPhone(phone);
  }
  Future<int> editPhone(PhoneModel phone) async {
    return await databaseHelper.updatePhone(phone);
  }
  Future<List<PhoneModel>> getPhones(studentId) async{
    return await databaseHelper.getPhonesByStudentId(studentId);
  }
    Future<PhoneModel> getPhone(phoneId) async{
    return await databaseHelper.getPhone(phoneId);
  }
    
  Future<int> addAddress(AddressModel address) async {
    return await databaseHelper.insertAddress(address);
  }
  Future<int> editAddress(AddressModel address) async {
    return await databaseHelper.updateAddress(address);
  }
  Future<List<AddressModel>> getAddresses(studentId) async{
    return await databaseHelper.getAddressesByStudentId(studentId);
  }
    Future<AddressModel> getAddress(addressId) async{
    return await databaseHelper.getAddress(addressId);
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
Future<void> deleteStudentData(int studentId) async {
  try {
    final rowsDeleted = await databaseHelper.deleteStudent(studentId);
 
  } catch (e) {

    throw 'Error al eliminar el telefono: $e';
  }
}
Future<void> deletePhoneData(int phoneId) async {
  try {
    final rowsDeleted = await databaseHelper.deletePhone(phoneId);
 
  } catch (e) {

    throw 'Error al eliminar el número de teléfono: $e';
  }
}
Future<void> deleteEmailData(String email) async {
  try {
    final rowsDeleted = await databaseHelper.deleteEmail(email);
 
  } catch (e) {

    throw 'Error al eliminar el correo: $e';
  }
}

Future<void> deleteAddressData(int addressId) async {
  try {
    final rowsDeleted = await databaseHelper.deleteAddress(addressId);
 
  } catch (e) {

    throw 'Error al eliminar el dirección: $e';
  }
}
}
