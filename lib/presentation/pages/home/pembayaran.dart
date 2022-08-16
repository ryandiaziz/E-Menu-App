import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class PembayaranPage extends StatefulWidget {
  final dynamic dataResponse;
  final dynamic dataUser;
  final dynamic dataCart;
  final int totalHarga;
  final int totalItems;
  final int countCart;
  final String idTransaksi;
  final String payMethod;
  const PembayaranPage({
    required this.dataResponse,
    required this.totalHarga,
    required this.idTransaksi,
    required this.dataCart,
    required this.payMethod,
    required this.countCart,
    required this.dataUser,
    required this.totalItems,
    Key? key,
  }) : super(key: key);

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  dynamic dataResponse;
  String? idOrder;
  Future getStatus() async {
    final url = Uri.parse(
        "http://10.140.175.73:3000/order/status/${widget.idTransaksi}");
    final response = await http.get(url);
    return dataResponse = json.decode(response.body);
  }

  @override
  void initState() {
    // action = widget.hasil['data']['response_midtrans'];
    super.initState();
  }

  Future addOrder() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String date = dateFormat.format(DateTime.now());
    var docOrder = FirebaseFirestore.instance.collection('order').doc();

    //Mencari Total Harga dan Total Items

    await docOrder.set({
      "id": docOrder.id,
      "idTransaksi": widget.idTransaksi,
      'payMethod': widget.payMethod,
      "namaPemesan": widget.dataUser[0]['name'],
      "imgPemesan": widget.dataUser[0]['imageUrl'],
      "emailPemesan": widget.dataUser[0]['email'],
      "totalHarga": widget.totalHarga,
      "totalItems": widget.totalItems,
      "date": date,
      "noMeja": widget.dataCart[0]['noMeja'],
      "idResto": widget.dataCart[0]['idResto'],
      "namaResto": widget.dataCart[0]['namaResto'],
      "imgResto": widget.dataCart[0]['imgResto'],
      "status": false,
      "isPay": true,
    });

    setState(() {
      idOrder = docOrder.id;
    });

    // Navigator.pushReplacementNamed(context, '/profile-ad');
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: const Text('Daftar Berhasil'),
    //   backgroundColor: priceColor,
    // ));
  }

  Future addItemsToOrder() async {
    for (var i = 0; i < widget.countCart; i++) {
      var docCheckout = FirebaseFirestore.instance
          .collection('order')
          .doc(idOrder)
          .collection('items')
          .doc();

      docCheckout.set({
        "id": docCheckout.id,
        "nama": widget.dataCart[i]['name'],
        "hargaAsli": widget.dataCart[i]['hargaAsli'],
        "hargaTotal":
            widget.dataCart[i]['quantityPrice'] ?? widget.dataCart[i]['harga'],
        "kuantitas": widget.dataCart[i]['quantity'],
        "kategori": widget.dataCart[i]["kategori"],
        "imageUrl": widget.dataCart[i]["imageUrl"],
        "idMenu": widget.dataCart[i]['idMenu'],
      });
    }

    // Navigator.pushReplacementNamed(context, '/profile-ad');
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: const Text('Daftar Berhasil'),
    //   backgroundColor: priceColor,
    // ));
  }

  Future deleteCart() async {
    for (var i = 0; i < widget.countCart; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc(widget.dataCart[i]["id"])
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTotalHarga() {
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.payMethod == 'gopay'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('GoPay'),
                          Image.network(
                            'https://gopay.co.id/icon.png',
                            width: 30,
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Virtual Account'),
                          Image.network(
                            'https://1.bp.blogspot.com/-L2iVgrayyhA/YGzwy2z5DfI/AAAAAAAAEmY/fxZIWA7r7X8g5qgYNXfVeWieoe0UKT3ygCLcBGAsYHQ/w1200-h630-p-k-no-nu/Logo%2BBank%2BPermata.png',
                            width: 100,
                          )
                        ],
                      ),
                Divider(
                  color: Colors.grey[200],
                ),
                const Text('Total Tagihan'),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format((widget.totalHarga)),
                )
              ]));
    }

    Widget costumBottomNav() {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 50,
        width: double.infinity,
        child: TextButton(
            onPressed: () async {
              await getStatus();

              if (dataResponse['data']['transaction_status'] == 'settlement') {
                await addOrder();
                await addItemsToOrder();
                await deleteCart();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: const Text('Pembayaran Berhasil'),
                  backgroundColor: priceColor,
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                );
              } else if (dataResponse['data']['transaction_status'] ==
                  'pending') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: const Text('Lakukan pembayaran'),
                  backgroundColor: priceColor,
                ));
              } else if (dataResponse['data']['transaction_status'] ==
                  'expire') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: const Text('transaksi gagal'),
                  backgroundColor: priceColor,
                ));
              }
              // for (var i = 0; i < countCart; i++) {
              //   setState(() {
              //     dataCart[i]['quantityPrice'] == null
              //         ? harga = dataCart[i]['harga']
              //         : harga = dataCart[i]['quantityPrice'];
              //     item = dataCart[i]['quantity'];
              //     totalItems = totalItems + item!;
              //     totalHarga = totalHarga + harga!;
              //   });
              // }
              // if (item != null) {
              //   if (item! > 0) {
              //     showModalBottomSheet(
              //       isDismissible: false,
              //       enableDrag: false,
              //       isScrollControlled: true,
              //       context: context,
              //       builder: (builder) =>
              //           bottomSheetCheckout(dataCart, countCart),
              //     );
              //   }
              // }
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   duration: const Duration(seconds: 1),
              //   content: const Text('Pesan dulu'),
              //   backgroundColor: alertColor,
              // ));

              // // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // //   content: const Text('Berhasil Menambah Pesanan'),
              // //   backgroundColor: priceColor,
              // // ));
            },
            style: TextButton.styleFrom(
              backgroundColor: priceColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              "Cek Status Pembayaran",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
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
          'Pembayaran',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: Column(
        children: [
          buildTotalHarga(),
          Expanded(child: SizedBox()),
          // Text('${dataResponse['data']['transaction_status']}'),
          costumBottomNav(),
          // Text('${widget.hasil['data']['id']}'),
          // // Image.network(widget.hasil['data']['response_midtrans']),
          // // Text('${widget.hasil['data']['response_midtrans']['action'][0]}'),
          // Text('${widget.hasil['data']['response_midtrans']['status_code']}'),
          // Text('==================================\n'),

          // Text(widget.hasil.toString()),
        ],
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
