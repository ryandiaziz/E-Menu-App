import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class BelumDibuat extends StatelessWidget {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Baris 1
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
                    height: 5,
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Container(
                width: 47,
                decoration: BoxDecoration(
                  // border: Border.all(color: priceColor, width: 0.5),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: secondsubtitleColor,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 5,
                  right: 10,
                ),
                child: Column(
                  children: [
                    Text('Meja',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 12, fontWeight: bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('5',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold)),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xffEFF0F6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "Sudah Bayar",
                style:
                    priceTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, "/checkout");
                },
                style: TextButton.styleFrom(
                    backgroundColor: priceColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "Selesai",
                  style: secondaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: semiBold),
                )),
          ),
        ],
      ),
    );
  }
}
