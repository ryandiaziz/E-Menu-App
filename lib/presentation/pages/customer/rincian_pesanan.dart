import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../card/items_order_card.dart';

class RincianPesananPage extends StatefulWidget {
  dynamic dataOrder;
  String? idResto;
  RincianPesananPage({this.dataOrder, this.idResto, Key? key})
      : super(key: key);

  @override
  State<RincianPesananPage> createState() =>
      _RincianPesananPageState(dataOrder, idResto);
}

class _RincianPesananPageState extends State<RincianPesananPage> {
  _RincianPesananPageState(this.dataOrder, this.idResto);
  String? idResto;
  dynamic dataOrder;

  @override
  Widget build(BuildContext context) {
    Widget costumBottomNav() {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // padding: const EdgeInsets.only(left: 10, right: 10),
        // height: idResto == null ? 110 : 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Waktu Pemesanan",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text(dataOrder['date'])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text('${dataOrder['totalItems']}')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(
                      (dataOrder['totalHarga']),
                    ),
                    style: dataOrder['bayar'] == false
                        ? alertTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14)
                        : priceTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14))
              ],
            ),
            idResto == null
                ? const SizedBox()
                : dataOrder['status'] == false
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            var upadateOrder = FirebaseFirestore.instance
                                .collection('order')
                                .doc(dataOrder['id']);

                            upadateOrder.update({
                              'status': true,
                            });
                            Navigator.pop(context);

                            // int newPrice = quantity * price;

                            // await addOrder(dataCart, countCart);
                            // await addItemsToOrder(dataCart, countCart);
                            // await deleteCart(dataCart, countCart);
                            // Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Pesanan Selesai',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: priceColor,
                            elevation: 3,
                          ),
                        ),
                      )
                    : const SizedBox(),
          ],
        ),
      );
    }

    Widget buildItems(dynamic dataItems, int countItems, String? idResto) {
      return Expanded(
        child: ListView.builder(
            itemCount: countItems,
            itemBuilder: (_, index) {
              return ItemsCardCus(
                dataItems: dataItems[index],
                idResto: idResto,
              );
            }),
      );
    }

    Widget getItems() {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("order")
            .doc(dataOrder['id'])
            .collection('items')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          dynamic dataItems = snapshot.data?.docs;
          int? countItems = snapshot.data?.docs.length;

          if (dataItems == null) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildItems(dataItems, countItems!, idResto),
              costumBottomNav(),
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
        elevation: 0,
        title: Text(
          "Rincian Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: getItems(),
    );
  }
}
