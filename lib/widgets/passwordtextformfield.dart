import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final TextEditingController controller;
  final String name;
  final Function() onTap;

  const PasswordTextFormField({
    required this.controller,
    required this.onTap,
    required this.name,
    required this.obserText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obserText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obserText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
