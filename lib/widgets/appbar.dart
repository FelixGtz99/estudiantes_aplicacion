import 'package:flutter/material.dart';

import 'package:estudiantes_aplicacion/utils/constant.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({required this.title, this.showActions = false});
  String title;
  bool showActions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
     automaticallyImplyLeading: false,
      actions: [
          if (showActions) IconButton(onPressed: () {

            Navigator.pushNamed(context, addStudent);
          }, icon: const Icon(Icons.add_circle_outline))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
