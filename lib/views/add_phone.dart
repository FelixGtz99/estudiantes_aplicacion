import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/views/phone_student.dart';
import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../models/phone.dart';

class AddPhone extends StatefulWidget {
  const AddPhone({required this.studentId});
  final int studentId;

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  final _phoneController = TextEditingController();
  final _areaCodeController = TextEditingController();
  final _countryCodeController = TextEditingController();

  StudentService studentService = StudentService();
  late String phone_type = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Agregar Teléfono'),
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          _phoneInput(),
          _countryCodeInput(),
          _areaCodeInput(),
          typeSelect()
        ]),
      ),
    );
  }

  Widget _phoneInput() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(hintText: 'Teléfono'),
    );
  }

  Widget _countryCodeInput() {
    return TextField(
      controller: _countryCodeController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(hintText: 'Código de país'),
    );
  }

  Widget _areaCodeInput() {
    return TextField(
      controller: _areaCodeController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(hintText: 'Código de Area '),
    );
  }

  Widget typeSelect() {
    return DropdownButtonFormField<String>(
      onChanged: (value) => {phone_type = value!},
      items: [
        const DropdownMenuItem<String>(
          value: 'Teléfono Fijo',
          child: Text('Teléfono Fijo'),
        ),
        const DropdownMenuItem<String>(
          value: 'Teléfono Movil',
          child: Text('Teléfono Movil'),
        ),
      ],
      hint: const Text('Tipo de Telefono'),
    );
  }

  saveData() async {
    PhoneModel phone = PhoneModel(
        phone: _phoneController.text,
        studentId: widget.studentId,
        phoneType: phone_type,
        areaCode: _areaCodeController.text,
        countryCode: _countryCodeController.text);

    try {
      await studentService.addPhone(phone).then((value) => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhoneStudent(
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
