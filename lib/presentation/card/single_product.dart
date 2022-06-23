import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final int price;
  final String name;

  const SingleProduct({
    required this.name,
    required this.price,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Rp ${price.toString()}',
                        style: priceTextStyle.copyWith(
                            fontSize: 14, fontWeight: bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icon/icon_star.png",
                          width: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "4.8",
                          style: titleTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
