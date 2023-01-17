import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final bool? borderColor;

  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.buttonWidth,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: borderColor == true ? priceColor : null,
          primary: backgroundColor ?? priceColor,
          elevation: 0,
          side: borderColor == true
              ? BorderSide(color: priceColor, width: 3)
              : null,
          textStyle:
              secondaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
