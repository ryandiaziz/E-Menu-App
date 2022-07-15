import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/pages/home/navigation.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/presentation/card/product_card.dart';

class MenuPage extends StatelessWidget {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget titleCatagories() {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border(
              top: BorderSide(
                width: 1,
                color: secondsubtitleColor,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Categories",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
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
                    width: 10,
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
              width: 10,
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Icon(
              Icons.bookmark,
              color: secondsubtitleColor,
              size: 50,
            ),
            Positioned(
              bottom: 19,
              right: 19,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: Text(
                    "99",
                    style: subtitleTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        title: Text(
          "Menu",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: secondsubtitleColor,
                size: 35,
              )),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          titleCatagories(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
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
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              mySheet(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: product(
                context,
                controller,
                "Nasi Goreng",
                12000,
                "assets/img/image_nasgor.jpg",
              ),
            ),
          )
        ],
      ),
    );
  }
}
