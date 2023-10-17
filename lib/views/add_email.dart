import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/views/mail_student.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({required this.studentId});
  final int studentId;

  @override
  State<AddEmail> createState() => _AddEmailState();
}

class _AddEmailState extends State<AddEmail> {
  final _emailController = TextEditingController();

  StudentService studentService = StudentService();
  late String email_type = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Agregar Correo'),
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [_emailInput(), typeSelect()]),
      ),
    );
  }

  Widget _emailInput() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Correo'),
    );
  }

  Widget typeSelect() {
    return DropdownButtonFormField<String>(
      onChanged: (value) => {email_type = value!},
      items: [
        const DropdownMenuItem<String>(
          value: 'Personal',
          child: Text('Personal'),
        ),
        const DropdownMenuItem<String>(
          value: 'Profesional',
          child: Text('Profesional'),
        ),
      ],
      hint: const Text('Tipo de Correo'),
    );
  }

  saveData() async {
    EmailModel email = EmailModel(
        email: _emailController.text,
        studentId: widget.studentId,
        emailType: email_type);
   
    try {
      await studentService.addEmail(email).then((value) => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MailStudent(
                studentId: widget.studentId,
              ),
            ))
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
