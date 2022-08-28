import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SaldoPage extends StatefulWidget {
  final String idResto;
  const SaldoPage({required this.idResto, Key? key}) : super(key: key);

  @override
  State<SaldoPage> createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  String dropdownvalue = 'users';
  var firestoreInstance = FirebaseFirestore.instance;

  // List of items in our dropdown menu
  var items = ['users', 'restaurants'];

  int totalSaldo = 0;
  List saldo = [];

  Future getTransaction() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("transaction")
        .where('idResto', isEqualTo: widget.idResto)
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        saldo.add({
          'namaPemesan': qn.docs[i]["namaPemesan"],
          'payMethod': qn.docs[i]["payMethod"],
          'date': qn.docs[i]["date"],
          'totalHarga': qn.docs[i]["totalHarga"],
        });
      }
    });
    return qn.docs;
  }

  void getTotalSaldo() {
    setState(() {
      for (var i = 0; i < saldo.length; i++) {
        totalSaldo = (totalSaldo + saldo[i]['totalHarga']) as int;
      }
    });
  }

  @override
  void initState() {
    getTransaction();
    Timer(const Duration(seconds: 2), () {
      getTotalSaldo();
    });

    super.initState();
  }

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
              "Belum ada transaksi",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    // Widget pilihData() {
    //   return Container(
    //     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     child: DropdownButton(
    //       value: dropdownvalue,
    //       hint: const Text('Kategori'),

    //       // Down Arrow Icon
    //       icon: const Icon(Icons.keyboard_arrow_down),
    //       isExpanded: true,
    //       itemHeight: 50,

    //       // Array list of items
    //       items: items.map((String items) {
    //         return DropdownMenuItem(
    //           value: items,
    //           child: Text(items),
    //         );
    //       }).toList(),
    //       // After selecting the desired option,it will
    //       // change button value to selected value
    //       onChanged: (String? newValue) {
    //         setState(() {
    //           dropdownvalue = newValue!;
    //         });
    //       },
    //     ),
    //   );
    // }

    Widget buildData() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: saldo.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Text(
                    saldo[index]['namaPemesan'],
                  ),
                ),
                title: Row(
                  children: [
                    Text(saldo[index]['payMethod']),
                  ],
                ),
                subtitle: Text(saldo[index]['date']),
                dense: true,
                trailing: Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format((saldo[index]['totalHarga'])),
                ),
              ),
            );
          });
    }

    // Widget getData() {
    //   return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance
    //         .collection('transaction')
    //         .where('idResto', isEqualTo: idResto)
    //         .snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             color: priceColor,
    //           ),
    //         );
    //       }
    //       if (snapshot.data!.docs.isEmpty) {
    //         return emptyOrder();
    //       }
    //       dynamic data = snapshot.data?.docs;
    //       int? countData = snapshot.data?.docs.length;

    //       return Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             color: Colors.amber,
    //             width: 100,
    //           ),
    //           buildData(),
    //         ],
    //       );
    //     },
    //   );
    // }
    Widget buildTotSaldo() {
      return Container(
        margin: const EdgeInsets.only(
          left: 10,
          bottom: 5,
          top: 20,
          right: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 5.0,
              offset: const Offset(4, 4),
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Saldo'),
            Text(
              NumberFormat.currency(
                locale: 'id',
                symbol: 'Rp ',
                decimalDigits: 0,
              ).format((totalSaldo)),
              style:
                  priceTextStyle.copyWith(fontWeight: semiBold, fontSize: 14),
            ),
          ],
        ),
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
            "Saldo",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: saldo.isNotEmpty
            ? Column(
                children: [
                  totalSaldo > 0
                      ? buildTotSaldo()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: priceColor,
                            ),
                          ),
                        ),
                  buildData(),
                ],
              )
            : emptyOrder());
  }
}
