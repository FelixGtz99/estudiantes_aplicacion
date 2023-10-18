import 'package:estudiantes_aplicacion/views/edit_student.dart';
import 'package:estudiantes_aplicacion/views/phone_student.dart';
import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/student.dart';
import '../widgets/appbar.dart';
import 'address_student.dart';
import 'mail_student.dart';

class StudentDetailScreen extends StatelessWidget {
  final int studentId;
  final StudentService studentService = StudentService();

  StudentDetailScreen({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detalles de el estudiante"),
      body: Center(
        child: FutureBuilder<StudentModel>(
          future: studentService.getStudentById(studentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('Estudiante no encontrado.');
            } else {
              final student = snapshot.data;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                 const CircleAvatar(radius: 60, child: Icon(Icons.person, size:55),),
                  ListTile(
                    title: Text('Nombre: ${student?.firstName}'),
                  ),
                  if(student?.middleName != '') ListTile(
                    title: Text('Segundo Nombre: ${student?.middleName}'),
                  ),
                       
                       ListTile(
                    title: Text('Apellido(s): ${student?.lastName}'),
                  ),
                  ListTile(
                    title: Text('Género: ${student?.gender}'),
                  ),
            
                  Padding(
  padding: const EdgeInsets.all(16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround, // Alinea los elementos en el centro con espacio entre ellos
    children: [
            IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditStudent(
              studentId: student?.studentId ?? 0,
            ),
          ));
        },
      ),
  IconButton(
        icon: Icon(Icons.email),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MailStudent(
              studentId: student?.studentId ?? 0,
            ),
          ));
        },
      ),
      IconButton(
        icon: Icon(Icons.phone),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhoneStudent(
              studentId: student?.studentId ?? 0,
            ),
          ));
        },
      ),
      IconButton(
        icon: Icon(Icons.location_on),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddressStudent(
              studentId: student?.studentId ?? 0,
            ),
          ));
        },
      ),
    ],
  ),
)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
