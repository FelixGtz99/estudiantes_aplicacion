import 'package:flutter/material.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../utils/constant.dart';
class EditStudent extends StatefulWidget {

 EditStudent({required this.studentId});
  final int studentId;
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  StudentService studentService = StudentService();
  
  late String gender = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Editar estudiante'),
      floatingActionButton: FloatingActionButton(onPressed:saveData,
       child: const Icon(Icons.save),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:FutureBuilder<StudentModel>(
          future: studentService.getStudentById(widget.studentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('Estudiante no encontrado.');
            } else {
              final student = snapshot.data;
              _firstNameController.text =student?.firstName ?? '';
              _middleNameController.text =student?.middleName ?? '';
              _lastNameController.text =student?.lastName ?? '';
              gender = student?.gender! ?? "Otro";
              return Column(
            children: [_firstNameInput(), _middleNameInput(), _lastNameInput(),genderSelect(student?.gender)]);
            }
          },
        ), 
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

  Widget genderSelect(value) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: (value)=>{
       gender = value!
      },
      items: [
        const DropdownMenuItem<String>(
          value:'Masculino',
          child: Text('Masculino'),
        ),
              const DropdownMenuItem<String>(
          value: 'Femenino',
          child: Text('Femenino'),
        ),
            const    DropdownMenuItem<String>(
          value: 'No binario',
          child: Text('No binario'),
        ),
              const  DropdownMenuItem<String>(
          value: 'Otro',
          child: Text('Otro'),
        ),
      ],
      hint: const Text('Genero'),
    );
  }
  
    saveData() async{
       StudentModel student  = StudentModel(studentId: widget.studentId,  lastName: _lastNameController.text, firstName: _firstNameController.text, middleName: _middleNameController.text, gender: gender);
   
      
    try {
      await studentService
          .editStudent(student)
          .then((value) => {Navigator.pushNamed(context, studentList)});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    }
}
