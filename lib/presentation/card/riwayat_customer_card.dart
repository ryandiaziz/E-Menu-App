import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class RiwayatCardCus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        // top: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: AssetImage("assets/img/image_nasgor.jpg"))),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Nasi Goreng",
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "05 Mei 2022, 08:00",
                    style: subtitleTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Makanan",
                    style: secondSubtitleTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        "2 x",
                        style: primaryTextStyle.copyWith(fontWeight: regular),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Rp 12.000",
                        style: priceTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColor.placeholder.withOpacity(0.25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: primaryTextStyle.copyWith(fontWeight: regular),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Rp24.000",
                style: primaryTextStyle.copyWith(fontWeight: regular),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColor.placeholder.withOpacity(0.25),
          ),
        ],
      ),
    );
  }
}
