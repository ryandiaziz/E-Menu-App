import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onPressed;
  final String name;

  const MyButton({
    required this.name,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: priceColor,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
