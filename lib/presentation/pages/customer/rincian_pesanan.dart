import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../card/items_order_card.dart';

class RincianPesananPage extends StatefulWidget {
  dynamic dataOrder;
  RincianPesananPage({this.dataOrder, Key? key}) : super(key: key);

  @override
  State<RincianPesananPage> createState() =>
      _RincianPesananPageState(dataOrder);
}

class _RincianPesananPageState extends State<RincianPesananPage> {
  _RincianPesananPageState(this.dataOrder);
  dynamic dataOrder;

  @override
  Widget build(BuildContext context) {
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
                Text('${dataOrder['totalHarga']}')
              ],
            ),
          ],
        ),
      );
    }

    Widget buildItems(dynamic dataItems, int countItems) {
      return Expanded(
        child: ListView.builder(
            itemCount: countItems,
            itemBuilder: (_, index) {
              return ItemsCardCus(
                dataItems: dataItems[index],
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
              buildItems(dataItems, countItems!),
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
