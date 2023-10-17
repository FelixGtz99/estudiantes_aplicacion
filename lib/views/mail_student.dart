import 'package:estudiantes_aplicacion/views/add_email.dart';
import 'package:flutter/material.dart';

import '../models/email.dart';
import '../services/student.dart';
import '../widgets/appbar.dart';
import 'edit_email.dart';

class MailStudent extends StatefulWidget {
  const MailStudent({required this.studentId});
  final int studentId;

  @override
  State<MailStudent> createState() => _MailStudentState();
}

class _MailStudentState extends State<MailStudent> {
  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddEmail(
                studentId: widget.studentId,
              ),
            ));
          },
          child: const Icon(Icons.add),
        ),
        appBar: CustomAppBar(title: 'Correos Estudiante'),
        body: Center(
          child: FutureBuilder<List<EmailModel>>(
            future: studentService.getEmail(widget.studentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No se encontraron Correos.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    EmailModel email = snapshot.data![index];
                    return emailTile(email, context);
                  },
                );
              }
            },
          ),
        ));
  }

  Widget emailTile(EmailModel email, context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(email.email!),
          subtitle: Text(email.emailType!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditEmail(
                      email: email.email ?? '',
                    ),
                  ));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => {

                        StudentService()
                      .deleteEmailData(email.email ?? '')
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
                icon: const Icon(Icons.remove_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
