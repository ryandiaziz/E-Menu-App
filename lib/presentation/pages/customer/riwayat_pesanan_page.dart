import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  @override
  Widget build(BuildContext context) {
    Widget emptyOrder() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/undraw_no_data_re_kwbl.svg",
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Belum ada pesanan",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget buildOrder(dynamic dataOrder, int countOrder) {
      return Expanded(
        child: ListView.builder(
            itemCount: countOrder,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          RincianPesananPage(dataOrder: dataOrder[index]),
                    ),
                  );
                },
                child: OrderCardCus(
                  dataOrder: dataOrder[index],
                ),
              );
            }),
      );
    }

    Widget getOrder() {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("order")
            .where('emailPemesan',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return emptyOrder();
          }
          dynamic dataOrder = snapshot.data?.docs;
          int? countOrder = snapshot.data?.docs.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildOrder(dataOrder, countOrder!),
              // costumBottomNav(dataCart, countCart)
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor,
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
        elevation: 1,
        title: Text(
          "Riwayat Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: getOrder(),
    );
  }
}
