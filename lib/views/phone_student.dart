
import 'package:flutter/material.dart';
import '../services/student.dart';
import 'package:estudiantes_aplicacion/views/add_phone.dart';

import '../models/phone.dart';
import '../widgets/appbar.dart';
import 'editPhone.dart';

class PhoneStudent extends StatelessWidget {
  const PhoneStudent({required this.studentId});
  final int studentId;
  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddPhone(
                studentId: studentId,
              ),
            ));
          },
          child: const Icon(Icons.add),
        ),
        appBar: CustomAppBar(title: 'Teléfonos Estudiante'),
        body: Center(
          child: FutureBuilder<List<PhoneModel>>(
            future: studentService.getPhones(studentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No se encontraron Teléfonos.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    PhoneModel phone = snapshot.data![index];
                    return phoneTile(phone, context);
                  },
                );
              }
            },
          ),
        ));
  }

  Widget phoneTile(PhoneModel phone, context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(phone.fullNumber!),
          subtitle: Text(phone.phoneType!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditPhone(
                      phoneId: phone.phoneId ?? 0,
                    ),
                  ));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.remove_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
