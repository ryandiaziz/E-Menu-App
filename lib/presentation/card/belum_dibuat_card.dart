import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BelumDibuat extends StatefulWidget {
  const BelumDibuat({Key? key}) : super(key: key);

  @override
  State<BelumDibuat> createState() => _BelumDibuatState();
}

class _BelumDibuatState extends State<BelumDibuat> {
  @override
  Widget build(BuildContext context) {
    String idResto = ModalRoute.of(context)!.settings.arguments as String;
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
            .where('idResto', isEqualTo: idResto)
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
      body: Container(),
    );
  }
}
