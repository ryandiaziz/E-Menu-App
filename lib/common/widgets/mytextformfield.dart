import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String image;
  final dynamic keyBoardType;

  const MyTextFormField({
    required this.image,
    required this.controller,
    required this.name,
    required this.keyBoardType,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      controller: controller,
      decoration: InputDecoration(
        icon: Image.asset(
          image,
          width: 18,
        ),
        border: const OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
