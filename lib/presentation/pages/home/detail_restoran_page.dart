import 'package:e_menu_app/presentation/card/product_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class DetailRestoran extends StatelessWidget {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: priceColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/img/img_restoran.jpg",
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Fridays Restaurant",
                    style: titleTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text("Jln. Medan-Banda Aceh",
                      style: secondSubtitleTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold)),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        )),
      );
    }

    return Scaffold(
        backgroundColor: AppColor.placeholderBg,
        body: ListView(
          children: [
            header(),
            const SizedBox(
              height: 10,
            ),
            product(
              context,
              controller,
              "Nasi Goreng",
              12000,
              "assets/img/image_burger.png",
            ),
          ],
        ));
  }
}
