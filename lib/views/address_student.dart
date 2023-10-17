import 'package:flutter/material.dart';

import '../services/student.dart';
import '../widgets/appbar.dart';
import 'package:estudiantes_aplicacion/views/add_address.dart';
import 'package:estudiantes_aplicacion/views/edit_address.dart';
import '../models/address.dart';

class AddressStudent extends StatefulWidget {
  const AddressStudent({required this.studentId});
  final int studentId;

  @override
  State<AddressStudent> createState() => _AddressStudentState();
}

class _AddressStudentState extends State<AddressStudent> {
  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAddress(
                studentId: widget.studentId,
              ),
            ));
          },
          child: const Icon(Icons.add),
        ),
        appBar: CustomAppBar(title: 'Direcciones Estudiante'),
        body: Center(
          child: FutureBuilder<List<AddressModel>>(
            future: studentService.getAddresses(widget.studentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No se encontraron Direcciones.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    AddressModel address = snapshot.data![index];
                    return addressTile(address, context);
                  },
                );
              }
            },
          ),
        ));
  }

  Widget addressTile(AddressModel address, context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(address.addressLine!),
          subtitle: Text(address.desc!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditAddress(
                      addressId: address.addressId ?? 0,
                    ),
                  ));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => {
                  StudentService()
                      .deleteAddressData(address.addressId ?? 0)
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
