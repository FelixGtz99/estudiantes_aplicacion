import 'package:estudiantes_aplicacion/utils/constant.dart';
import 'package:estudiantes_aplicacion/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
                 onGenerateRoute: Routes().onGenerateRoute,
                 initialRoute: studentList,
    );
  }
}
