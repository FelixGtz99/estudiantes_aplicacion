
import 'package:estudiantes_aplicacion/views/add_student.dart';
import 'package:estudiantes_aplicacion/views/student_list.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/utils/constant.dart';
class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case studentList:
        return MaterialPageRoute(builder: (_) => const StudentList());
      case addStudent:
        return MaterialPageRoute(builder: (_) =>  AddStudent());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404 | Not Found'),
            ),
          ),
        );
    }
  }
}
