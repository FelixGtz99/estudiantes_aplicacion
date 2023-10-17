import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/views/address_student.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../models/address.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({required this.studentId});
  final int studentId;

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _addressLineController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  StudentService studentService = StudentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Agregar Dirección'),
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          _addressLineInput(),
          _cityInput(),
          _zipInput(),
          _stateInput()
        ]),
      ),
    );
  }

  Widget _addressLineInput() {
    return TextField(
      controller: _addressLineController,
      decoration: const InputDecoration(hintText: 'Dirección'),
    );
  }

  Widget _cityInput() {
    return TextField(
      controller: _cityController,
      decoration: const InputDecoration(hintText: 'Ciudad'),
    );
  }

  Widget _zipInput() {
    return TextField(
      controller: _zipController,
      decoration: const InputDecoration(hintText: 'Código postal'),
    );
  }

  Widget _stateInput() {
    return TextField(
      controller: _stateController,
      decoration: const InputDecoration(hintText: 'Estado'),
    );
  }

  saveData() async {
    AddressModel address = AddressModel(
        studentId: widget.studentId,
        addressLine: _addressLineController.text,
        city: _cityController.text,
        zipPostcode: _zipController.text,
        state: _stateController.text);

    try {
      await studentService.addAddress(address).then((value) => {

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>AddressStudent(
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
