import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class RestoranCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/img/img_restoran.jpg',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fridays Restaurant",
                  style:
                      titleTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("Jln. Medan-Banda Aceh",
                    style: secondSubtitleTextStyle.copyWith(
                        fontSize: 14, fontWeight: bold)),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
