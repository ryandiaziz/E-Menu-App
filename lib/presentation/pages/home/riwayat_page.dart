import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/shared/theme.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return ListView(
        children: const [
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
