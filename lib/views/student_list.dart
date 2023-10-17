import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';
class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Estudiantes'),
    );
  }
}