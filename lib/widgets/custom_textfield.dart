import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomTextField extends StatelessWidget {
  final String image;
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    required this.image,
    required this.controller,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xffEFF0F6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    image,
                    width: 17,
                    color: secondsubtitleColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: hintText, hintStyle: subtitleTextStyle),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
