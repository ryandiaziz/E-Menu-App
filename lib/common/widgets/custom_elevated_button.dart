import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    Key? key,
    this.buttonWidth,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle:
              secondaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
          primary: priceColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
