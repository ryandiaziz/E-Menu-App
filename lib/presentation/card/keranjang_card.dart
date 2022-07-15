import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class BagCard extends StatefulWidget {
  @override
  State<BagCard> createState() => _BagCardState();
}

class _BagCardState extends State<BagCard> {
  int i = 1;
  int price = 28000;

  void _minus() {
    setState(() {
      if (i > 1) {
        i--;
      }
    });
  }

  void _plus() {
    setState(() {
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        bottom: 5,
        top: 5,
        right: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: secondaryColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 3.0,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-2, 0),
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Nasi Goreng",
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Makanan",
                      style: secondSubtitleTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Rp $price",
                      style: priceTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/icon/icon_remove.png",
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 35,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xffEFF0F6),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _minus,
                      child: Image.asset(
                        "assets/icon/icon_min.png",
                        width: 25,
                        color: priceColor,
                      ),
                    ),
                    Text(
                      "$i",
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                    ),
                    GestureDetector(
                      onTap: _plus,
                      child: Image.asset(
                        "assets/icon/icon_max.png",
                        width: 25,
                        color: priceColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
