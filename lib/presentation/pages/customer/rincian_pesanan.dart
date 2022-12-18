import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

import '../../card/items_order_card.dart';

class RincianPesananPage extends StatefulWidget {
  final dynamic dataOrder;
  final String? idResto;
  const RincianPesananPage({this.dataOrder, this.idResto, Key? key})
      : super(key: key);

  @override
  State<RincianPesananPage> createState() =>
      _RincianPesananPageState(dataOrder, idResto);
}

class _RincianPesananPageState extends State<RincianPesananPage> {
  _RincianPesananPageState(this.dataOrder, this.idResto);

  String? idResto;
  dynamic dataOrder;
  dynamic dataItem;
  int? countItem;

  Future addTransaction() async {
    const uuid = Uuid();
    String _idTransaksi = uuid.v1();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String date = dateFormat.format(DateTime.now());
    var docTransaction =
        FirebaseFirestore.instance.collection('transaction').doc(_idTransaksi);

    await docTransaction.set({
      "id": _idTransaksi,
      "idOrder": dataOrder['id'],
      'payMethod': dataOrder['payMethod'],
      "namaPemesan": dataOrder['namaPemesan'],
      "emailPemesan": dataOrder['emailPemesan'],
      "totalHarga": dataOrder['totalHarga'],
      "date": date,
      "noMeja": dataOrder['noMeja'],
      "idResto": dataOrder['idResto'],
      "namaResto": dataOrder['namaResto'],
    });
  }

  Future addChart() async {
    QuerySnapshot checkCharts = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(idResto)
        .collection('chart')
        .get();

    if (checkCharts.docs.isEmpty) {
      print(countItem);
      for (var i = 0; i < countItem!; i++) {
        var docChart = FirebaseFirestore.instance
            .collection('restaurants')
            .doc(idResto)
            .collection('chart')
            .doc(dataItem[i]['nama']);

        docChart.set({
          'nama': dataItem[i]['nama'],
          'orders': 1,
        });
      }
    }
    for (var i = 0; i < countItem!; i++) {
      int cek = 0;
      for (var j = 0; j < checkCharts.docs.length; j++) {
        //Cek, Apakah ada data yang sama?
        if (dataItem[i]['nama'] == checkCharts.docs[j]['nama']) {
          //Meng-update data
          var docChart = FirebaseFirestore.instance
              .collection('restaurants')
              .doc(idResto)
              .collection('chart')
              .doc(dataItem[i]['nama']);

          docChart.update({
            'orders': checkCharts.docs[j]['orders'] + 1,
          });
        } else if (dataItem[i]['nama'] != checkCharts.docs[j]['nama']) {
          //Cek semua data kesamaan produk
          cek = cek + 1;
          //Tambah data baru, setelah mengecek semua data tidak ada yang sama
          if (cek == checkCharts.docs.length) {
            var docChart = FirebaseFirestore.instance
                .collection('restaurants')
                .doc(idResto)
                .collection('chart')
                .doc(dataItem[i]['nama']);

            docChart.set({
              'nama': dataItem[i]['nama'],
              'orders': 1,
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget costumBottomNav(dynamic dataItems, int countItems, String? idResto) {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  "ID Pesanan",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text(dataOrder['id'])
              ],
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
            const SizedBox(
              height: 5,
            ),
            idResto != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama Pemesanan",
                        style: subtitleTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text(dataOrder['namaPemesan'])
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama Restoran",
                        style: subtitleTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text(dataOrder['namaResto'])
                    ],
                  ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metode Pembayaran",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text(dataOrder['payMethod'])
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No Meja",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
                Text(dataOrder['noMeja'])
              ],
            ),
            const SizedBox(
              height: 5,
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
            const SizedBox(
              height: 5,
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
                    style: dataOrder['isPay'] == false
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
                            setState(() {
                              dataItem = dataItems;
                              countItem = countItems;
                            });
                            // print(dataItem[0]['nama']);
                            addChart();
                            Navigator.pop(context);
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
                    : dataOrder['isPay'] == false
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
                                  'isPay': true,
                                });
                                addTransaction();
                                Navigator.pop(context);

                                // int newPrice = quantity * price;

                                // await addOrder(dataCart, countCart);
                                // await addItemsToOrder(dataCart, countCart);
                                // await deleteCart(dataCart, countCart);
                                // Navigator.of(context).pop();
                                // Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Konfirmasi Pembayaran',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
              costumBottomNav(dataItems, countItems, idResto),
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
          "Rincian Pesanan",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: getItems(),
    );
  }
}
