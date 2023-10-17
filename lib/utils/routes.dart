
import 'package:estudiantes_aplicacion/views/student_list.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/utils/constant.dart';
class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case studentList:
        return MaterialPageRoute(builder: (_) => const StudentList());


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
