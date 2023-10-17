import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/student.dart';
import '../widgets/appbar.dart';
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
                  ListTile(
                    title: Text('Nombre: ${student?.fullName}'),
                  ),
                  ListTile(
                    title: Text('Género: ${student?.gender}'),
                  ),
      
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar'),
                    onTap: () {
                     
                    },
                  ),
              
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Correo'),
                    onTap: () {
                    },
                  ),
               
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Teléfono'),
                    onTap: () {
                    
                    },
                  ),
        
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: const Text('Direcciones'),
                    onTap: () {
                   
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}