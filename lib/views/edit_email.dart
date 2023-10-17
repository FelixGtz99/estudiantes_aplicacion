import 'package:flutter/material.dart';
import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import 'mail_student.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({required this.email});

  final String email;
  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  final _emailController = TextEditingController();

  StudentService studentService = StudentService();
  late String email_type = '';
  int studentId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Editar Correo'),
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<EmailModel>(
          future: studentService.getDataEmail(widget.email),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('Estudiante no encontrado.');
            } else {
              final email = snapshot.data;
              _emailController.text = email?.email ?? '';
              studentId = email?.studentId ?? 0;

              return Column(
                  children: [_emailInput(), typeSelect(email?.emailType)]);
            }
          },
        ),
      ),
    );
  }

  Widget _emailInput() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Correo'),
    );
  }

  Widget typeSelect(value) {
    return DropdownButtonFormField<String>(
      value: value,
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
        studentId: studentId,
        emailType: email_type);
    try {
      await studentService.editEmail(email).then((value) => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MailStudent(
                studentId: studentId,
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
