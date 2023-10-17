import 'package:estudiantes_aplicacion/models/student.dart';
import 'package:flutter/material.dart';

Widget studentTile(StudentModel student) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Card(
      color: Colors.white,
      child: ListTile(
        title: Text(student.fullName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => OmitShop(
                //       routeShopId: shop.route_shop_id,
                //     ),
                //   ),
                // );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ),
  );
}
