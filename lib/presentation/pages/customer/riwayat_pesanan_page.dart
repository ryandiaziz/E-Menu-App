import 'package:e_menu_app/presentation/card/riwayat_customer_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  @override
  Widget build(BuildContext context) {
    Widget content() {
      return ListView(
        children: [
          RiwayatCardCus(),
          RiwayatCardCus(),
          RiwayatCardCus(),
          RiwayatCardCus(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: secondsubtitleColor,
          ),
        ),
        automaticallyImplyLeading: true,
        titleSpacing: -5,
        elevation: 0,
        title: Text(
          "Riwayat Pesanan Anda",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: content(),
    );
  }
}
