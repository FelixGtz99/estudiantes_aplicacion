import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:flutter/material.dart';

import '../views/student.dart';

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
              onPressed: () => {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ),
  );
}
