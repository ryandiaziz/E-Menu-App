import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/pages/home/main_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/presentation/card/product_card.dart';

class HomePagee extends StatelessWidget {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget location() {
      return Row(
        children: [
          Image.asset(
            "assets/icon/icon_location.png",
            width: 20,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            "Meja No 1",
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );
    }

    Widget search() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(
                    12.5,
                  ),
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: subtitleColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon/icon_search.png",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 16,
            ),
            Image.asset(
              "assets/icon/Icon_filter.png",
              width: 48,
            )
          ],
        ),
      );
    }

    Widget titleCatagories() {
      return Container(
        margin: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget scrollCategories(gambar, text) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              height: 40,
              decoration: BoxDecoration(
                color: priceColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    gambar,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    text,
                    style: secondaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
      );
    }

    Widget modalsheet() {
      return Container(
        height: 300,
        padding: const EdgeInsets.only(
          // top: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: secondaryColor,
        ),
        child: Container(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Baris 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nasi Goreng",
                    style:
                        titleTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/icon_star.png",
                        width: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "4.8",
                        style: titleTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "(41 Reviews)",
                        style: titleTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              //Baris 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/img/image_nasgor.jpg",
                    width: 100,
                  ),
                  Text(
                    "Rp22.00",
                    style:
                        priceTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                  ),
                ],
              ),
              //Bariis 3
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
                          Image.asset(
                            "assets/icon/icon_min.png",
                            width: 25,
                            color: priceColor,
                          ),
                          Text(
                            "1",
                            style: titleTextStyle.copyWith(
                                fontSize: 18, fontWeight: semiBold),
                          ),
                          Image.asset(
                            "assets/icon/icon_max.png",
                            width: 25,
                            color: priceColor,
                          ),
                        ]),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: priceColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {},
                    child: Text(
                      "Tambahkan ke Keranjang",
                      style: secondaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                    )),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      body: Container(
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            location(),
            search(),
            titleCatagories(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  scrollCategories(
                    "assets/img/image_burger.png",
                    "Burger",
                  ),
                  scrollCategories(
                    "assets/icon/icon_sandwich.png",
                    "Sandwich",
                  ),
                  scrollCategories(
                    "assets/img/image_burger.png",
                    "Burger",
                  ),
                  scrollCategories(
                    "assets/img/image_burger.png",
                    "Burger",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) => modalsheet(),
                  );
                },
                child: product(context, controller))
          ],
        ),
      ),
    );
  }
}
