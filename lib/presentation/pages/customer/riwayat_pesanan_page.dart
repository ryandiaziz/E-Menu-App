import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  @override
  Widget build(BuildContext context) {
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
          dynamic dataOrder = snapshot.data?.docs;
          int? countOrder = snapshot.data?.docs.length;

          if (dataOrder == null) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
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
          "Riwayat Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: getOrder(),
    );
  }
}
