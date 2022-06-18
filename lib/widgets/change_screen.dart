import 'package:flutter/material.dart';

import '../shared/theme.dart';

class ChangeScreen extends StatelessWidget {
  final String teks, screenTeks;
  final Function() onTapp;

  const ChangeScreen({
    required this.teks,
    required this.onTapp,
    required this.screenTeks,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(teks, style: subtitleTextStyle.copyWith(fontSize: 12)),
          GestureDetector(
            onTap: onTapp,
            child: Text(
              screenTeks,
              style: priceTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          )
        ],
      ),
    );
  }
}
