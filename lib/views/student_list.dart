import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/widgets/student_tile.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: CustomAppBar(title: 'Estudiantes',showActions: true,),
          body: FutureBuilder<List<StudentModel>>(
            future: studentService.fetchStudents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No se encontraron estudiantes.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    StudentModel student = snapshot.data![index];
                    return studentTile(student);
                  },
                );
              }
            },
          )),
    );
  }
}
