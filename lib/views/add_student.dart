import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../utils/constant.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  StudentService studentService = StudentService();
  late String gender = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Nuevo estudiante'),
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          _firstNameInput(),
          _middleNameInput(),
          _lastNameInput(),
          genderSelect()
        ]),
      ),
    );
  }

  Widget _firstNameInput() {
    return TextField(
      controller: _firstNameController,
      decoration: const InputDecoration(hintText: 'Primer Nombre'),
    );
  }

  Widget _middleNameInput() {
    return TextField(
      controller: _middleNameController,
      decoration: const InputDecoration(hintText: 'Segundo Nombre'),
    );
  }

  Widget _lastNameInput() {
    return TextField(
      controller: _lastNameController,
      decoration: const InputDecoration(hintText: 'Apellido(s)'),
    );
  }

  Widget genderSelect() {
    return DropdownButtonFormField<String>(
      onChanged: (value) => {gender = value!},
      items: [
        const DropdownMenuItem<String>(
          value: 'Masculino',
          child: Text('Masculino'),
        ),
        const DropdownMenuItem<String>(
          value: 'Femenino',
          child: Text('Femenino'),
        ),
        const DropdownMenuItem<String>(
          value: 'No binario',
          child: Text('No binario'),
        ),
        const DropdownMenuItem<String>(
          value: 'Otro',
          child: Text('Otro'),
        ),
      ],
      hint: const Text('Genero'),
    );
  }

  saveData() async {
    StudentModel student = StudentModel(
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        gender: gender);

    try {
      await studentService
          .addStudent(student)
          .then((value) => {Navigator.pushNamed(context, studentList)});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
