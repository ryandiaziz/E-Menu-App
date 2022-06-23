import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String image;

  const MyTextFormField({
    required this.image,
    required this.controller,
    required this.name,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Image.asset(image),
        border: const OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
