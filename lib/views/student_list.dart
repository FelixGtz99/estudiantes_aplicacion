import 'package:estudiantes_aplicacion/views/student.dart';
import 'package:flutter/material.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/widgets/appbar.dart';



class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: CustomAppBar(title: 'Estudiantes',showActions: true,),
          body: Center(
            child: FutureBuilder<List<StudentModel>>(
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
                      return studentTile(student, context);
                    },
                  );
                }
              },
            ),
          )),
    );
  }

  Widget studentTile(StudentModel student, context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Card(
      color: Colors.white,
      child: ListTile(
        title: Text(student.fullName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(
                      studentId: student.studentId ?? 0,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.visibility),
            ),
            IconButton(
              onPressed: () => {

                        StudentService()
                      .deleteStudentData(student.studentId ?? 0)
                      .then((value) {
                        setState(() {
                          
                        });
                      })
                      .onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString())),
                    );
                  })
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ),
  );
}
}
