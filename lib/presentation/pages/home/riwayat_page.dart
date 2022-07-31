import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/shared/theme.dart';

class RiwayatPage extends StatelessWidget {
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
            const SizedBox(
              height: 20,
            ),
            Text(
              "Opss! Your Cart is Empty",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Let's find your favorite shoes",
              style: secondSubtitleTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
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
          OrderCardCus(),
          OrderCardCus(),
          OrderCardCus(),
          OrderCardCus(),
          OrderCardCus(),
        ],
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
          "Riwayat Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: content(),
    );
  }
}
