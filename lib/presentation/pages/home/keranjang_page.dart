import 'package:e_menu_app/presentation/card/keranjang_card.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class BagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/icon_empty_cart.png",
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Opss! Your Cart is Empty",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Let's find your favorite shoes",
              style: secondSubtitleTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 44,
              width: 152,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: TextButton.styleFrom(
                    backgroundColor: priceColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Text(
                  "Explore Store",
                  style: secondaryTextStyle.copyWith(
                      fontWeight: medium, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        children: [
          BagCard(),
          BagCard(),
          BagCard(),
          BagCard(),
          BagCard(),
          BagCard(),
          BagCard(),
        ],
      );
    }

    Widget costumBottomNav() {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 110,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                Text(
                  "Rp 287.000",
                  style: priceTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 16),
                ),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, "/checkout");
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: priceColor,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Continue",
                        style: secondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: secondaryColor,
                      )
                    ],
                  )),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.placeholderBg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: content(),
      bottomNavigationBar: costumBottomNav(),
    );
  }
}
