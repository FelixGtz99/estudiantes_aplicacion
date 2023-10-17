import 'package:flutter/material.dart';
import 'package:estudiantes_aplicacion/services/student.dart';
import 'package:estudiantes_aplicacion/widgets/appbar.dart';

import '../models/address.dart';
class EditAddress extends StatefulWidget {
  const EditAddress({required this.addressId});

  final int addressId;
  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _addressLineController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  
  StudentService studentService = StudentService();
  late String phone_type = '';
  int studentId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Editar Correo'),
      floatingActionButton: FloatingActionButton(onPressed:saveData,
       child: const Icon(Icons.save),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        
        FutureBuilder<AddressModel>(
          future: studentService.getAddress(widget.addressId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('Dirección no encontrada.');
            } else {
              final address= snapshot.data;
              _addressLineController.text =address?.addressLine ?? '';
              _cityController.text =address?.city ?? '';
              _stateController.text =address?.state ?? '';
              _zipController.text =address?.zipPostcode ?? '';
           

              studentId = address?.studentId ?? 0;
       
              return   Column(
            children: [_addressLineInput(), _cityInput(), _zipInput(),  _stateInput()  ]);
            }
          },
        ), 
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
    saveData() async{
     AddressModel address = AddressModel(addressId: widget.addressId, studentId: studentId, addressLine: _addressLineController.text, city: _cityController.text, zipPostcode: _zipController.text, state: _stateController.text);
       await  studentService.editAddress(address).then((value) => {
        print(value)
       });
      
    }
}
