import 'package:estudiantes_aplicacion/views/phone_student.dart';
import 'package:flutter/material.dart';
import 'package:estudiantes_aplicacion/models/email.dart';
import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:estudiantes_aplicacion/services/student.dart';

import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../models/phone.dart';

class EditPhone extends StatefulWidget {
  const EditPhone({required this.phoneId});

  final int phoneId;
  @override
  State<EditPhone> createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  final _phoneController = TextEditingController();
  final _areaCodeController = TextEditingController();
  final _countryCodeController = TextEditingController();

  StudentService studentService = StudentService();
  late String phone_type = '';
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
        child: FutureBuilder<PhoneModel>(
          future: studentService.getPhone(widget.phoneId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('Teléfono no encontrado.');
            } else {
              final phone = snapshot.data;
              _phoneController.text = phone?.phone ?? '';
              _areaCodeController.text = phone?.areaCode ?? '';
              _countryCodeController.text = phone?.countryCode ?? '';

              studentId = phone?.studentId ?? 0;

              return Column(children: [
                _phoneInput(),
                _countryCodeInput(),
                _areaCodeInput(),
                typeSelect(phone?.phoneType)
              ]);
            }
          },
        ),
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
      decoration: const InputDecoration(hintText: 'Código de Area'),
    );
  }

  Widget typeSelect(value) {
    return DropdownButtonFormField<String>(
      value: value,
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
        phoneId: widget.phoneId,
        phone: _phoneController.text,
        studentId: studentId,
        phoneType: phone_type,
        areaCode: _areaCodeController.text,
        countryCode: _countryCodeController.text);
    try {
      await studentService.editPhone(phone).then((value) => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhoneStudent(
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
