import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/api/api_base_helper.dart';
import 'package:e_menu_app/presentation/pages/home/pembayaran.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/api/api_base_helper.dart';
import 'package:e_menu_app/api/api_response.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class BagPage extends StatefulWidget {
  dynamic dataMeja;
  dynamic dataUser;

  BagPage({this.dataMeja, this.dataUser, Key? key}) : super(key: key);
  @override
  State<BagPage> createState() => _BagPageState(dataMeja, dataUser);
}

class _BagPageState extends State<BagPage> {
  _BagPageState(
    this.dataMeja,
    this.dataUser,
  );
  var firestoreInstance = FirebaseFirestore.instance;
  ApiBaseHelper api = ApiBaseHelper();
  int? newPrice;
  dynamic dataMeja;
  dynamic dataUser;
  List dataCart = [];

  String? idCheckout;
  int? harga;
  int totalHarga = 0;
  String? idOrder;
  int? item;
  int totalItems = 0;
  String? pembayaran;
  bool? isPay;

  //Fungsi Menambahkah Data Pesanan
  Future addOrder(
      dynamic dataCart, int countCart, bool isPay, String payMethod) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String date = dateFormat.format(DateTime.now());
    var docOrder = FirebaseFirestore.instance.collection('order').doc();
    //Mencari Total Harga dan Total Items

    await docOrder.set({
      "id": docOrder.id,
      "idTransaksi": null,
      'payMethod': payMethod,
      "namaPemesan": dataUser[0]['name'],
      "imgPemesan": dataUser[0]['imageUrl'],
      "emailPemesan": dataUser[0]['email'],
      "totalHarga": totalHarga,
      "totalItems": totalItems,
      "date": date,
      "noMeja": dataCart[0]['noMeja'],
      "idResto": dataCart[0]['idResto'],
      "namaResto": dataCart[0]['namaResto'],
      "imgResto": dataCart[0]['imgResto'],
      "status": false,
      "isPay": isPay,
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

  Future addItemsToOrder(dynamic dataCart, int countCart) async {
    for (var i = 0; i < countCart; i++) {
      var docCheckout = FirebaseFirestore.instance
          .collection('order')
          .doc(idOrder)
          .collection('items')
          .doc();

      docCheckout.set({
        "id": docCheckout.id,
        "nama": dataCart[i]['name'],
        "hargaAsli": dataCart[i]['hargaAsli'],
        "hargaTotal": dataCart[i]['quantityPrice'] ?? dataCart[i]['harga'],
        "kuantitas": dataCart[i]['quantity'],
        "kategori": dataCart[i]["kategori"],
        "imageUrl": dataCart[i]["imageUrl"],
        "idMenu": dataCart[i]['idMenu'],
      });
    }

    // Navigator.pushReplacementNamed(context, '/profile-ad');
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: const Text('Daftar Berhasil'),
    //   backgroundColor: priceColor,
    // ));
  }

  Future deleteCart(dynamic dataCart, int countCart) async {
    for (var i = 0; i < countCart; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc(dataCart[i]["id"])
          .delete();
    }
  }

  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    Widget bottomSheetCheckout(dynamic dataCart, int countCart) {
      return StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Checkout",
                    style: primaryTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 22),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        harga = 0;
                        totalHarga = 0;
                        item = 0;
                        totalItems = 0;
                      });
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              RadioListTile<int>(
                  title: const Text('Go-Pay'),
                  value: 0,
                  groupValue: selectedValue,
                  onChanged: (value) => setState(() {
                        selectedValue = value!;
                        pembayaran = 'gopay';
                      })),
              RadioListTile<int>(
                  title: const Text('Bank Permata'),
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (value) => setState(() {
                        selectedValue = value!;
                        pembayaran = 'permata';
                      })),
              RadioListTile<int>(
                  title: const Text('COD'),
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (value) => setState(() {
                        selectedValue = value!;
                        pembayaran = 'cod';
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nama Pemesan',
                      style: subtitleTextStyle.copyWith(fontSize: 14)),
                  Text(
                    dataUser[0]['name'],
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email',
                      style: subtitleTextStyle.copyWith(fontSize: 14)),
                  Text(
                    dataUser[0]['email'],
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Meja', style: subtitleTextStyle.copyWith(fontSize: 14)),
                  Text(
                    dataMeja['noMeja'],
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items',
                      style: subtitleTextStyle.copyWith(fontSize: 14)),
                  Text(
                    '$totalItems',
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga',
                      style: subtitleTextStyle.copyWith(fontSize: 14)),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format((totalHarga)),
                    style: priceTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 14),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (pembayaran == 'gopay') {
                      const uuid = Uuid();
                      String _idTransaksi = uuid.v1();
                      Map data = {
                        "payment_type": "gopay",
                        "transaction_details": {
                          "order_id": _idTransaksi,
                          "gross_amount": totalHarga
                        },
                        // "item_details": [
                        //   {
                        //     "id": dataMeja['idResto'],
                        //     "price": totalHarga - 1,
                        //     "quantity": totalItems,
                        //     "name": dataMeja['noMeja']
                        //   }
                        // ],
                        "customer_details": {
                          "first_name": dataUser[0]['name'],
                          "last_name": "",
                          "email": dataUser[0]['email'],
                          "phone": dataUser[0]['phone']
                        },
                        "gopay": {
                          "enable_callback": true,
                          "callback_url": "someapps://callback"
                        },
                        "tiket_id": _idTransaksi,
                        'nama': dataUser[0]['name']
                      };

                      var body = json.encode(data);
                      final response = await api.post(
                          "http://10.140.216.225:3000/order/charge", body);
                      // final dataResponse = json.decode(response);
                      // print('==========\n');
                      // print(dataResponse['status']);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PembayaranPage(
                            dataResponse: response,
                            totalHarga: totalHarga,
                            idTransaksi: _idTransaksi,
                            payMethod: 'gopay',
                            dataUser: dataUser,
                            totalItems: totalItems,
                            dataCart: dataCart,
                            countCart: countCart,
                          ),
                        ),
                      );
                    } else if (pembayaran == 'permata') {
                      const uuid = Uuid();
                      String _idTransaksi = uuid.v1();
                      Map data = {
                        "payment_type": "bank_transfer",
                        "bank_transfer": {"bank": "permata"},
                        "transaction_details": {
                          "order_id": _idTransaksi,
                          "gross_amount": totalHarga
                        },
                        "tiket_id": _idTransaksi,
                        "nama": dataUser[0]['name']
                      };

                      var body = json.encode(data);
                      final response = await api.post(
                          "http://10.140.216.225:3000/order/charge", body);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PembayaranPage(
                            dataResponse: response,
                            totalHarga: totalHarga,
                            idTransaksi: _idTransaksi,
                            payMethod: 'permata',
                            dataUser: dataUser,
                            totalItems: totalItems,
                            countCart: countCart,
                            dataCart: dataCart,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isPay = false;
                      });
                      await addOrder(dataCart, countCart, isPay!, 'cod');
                      await addItemsToOrder(dataCart, countCart);
                      await deleteCart(dataCart, countCart);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                    //

                    //
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: priceColor,
                    elevation: 3,
                  ),
                ),
              )
            ],
          ),
        );
      });
    }

    Widget costumBottomNav(dynamic dataCart, int countCart) {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        height: 110,
        child: SizedBox(
          height: 50,
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
              onPressed: () async {
                for (var i = 0; i < countCart; i++) {
                  setState(() {
                    dataCart[i]['quantityPrice'] == null
                        ? harga = dataCart[i]['harga']
                        : harga = dataCart[i]['quantityPrice'];
                    item = dataCart[i]['quantity'];
                    totalItems = totalItems + item!;
                    totalHarga = totalHarga + harga!;
                  });
                }
                if (item != null) {
                  if (item! > 0) {
                    showModalBottomSheet(
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (builder) =>
                          bottomSheetCheckout(dataCart, countCart),
                    );
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: const Text('Pesan dulu'),
                  backgroundColor: alertColor,
                ));

                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: const Text('Berhasil Menambah Pesanan'),
                //   backgroundColor: priceColor,
                // ));
              },
              style: TextButton.styleFrom(
                backgroundColor: priceColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Continue",
                    style: secondaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: semiBold),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: secondaryColor,
                  )
                ],
              )),
        ),
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/icon_empty_cart.png",
              width: 80,
              color: priceColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Opss! Your Cart is Empty",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget buildCart(dynamic dataCart, int countCart) {
      return Expanded(
        child: ListView.builder(
            itemCount: countCart,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  bottom: 5,
                  top: 5,
                  right: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: secondaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3.0,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-2, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Baris 1
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                dataCart[index]['imageUrl'],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                dataCart[index]['name'],
                                style: primaryTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                dataCart[index]['kategori'],
                                style: secondSubtitleTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              dataCart[index]['cQP'] == null
                                  ? Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format((dataCart[index]['harga'])),
                                      style: priceTextStyle.copyWith(
                                          fontWeight: semiBold, fontSize: 14),
                                    )
                                  : Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(
                                          (dataCart[index]['quantityPrice'])),
                                      style: priceTextStyle.copyWith(
                                          fontWeight: semiBold, fontSize: 14),
                                    ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("cart")
                                .doc(dataCart[index]['id'])
                                .delete();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              content: const Text('Menu Dihapus'),
                              backgroundColor: alertColor,
                            ));
                          },
                          child: Image.asset(
                            "assets/icon/icon_remove.png",
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFF0F6),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    int quantity = dataCart[index]['quantity'];
                                    int price = dataCart[index]['harga'];
                                    if (quantity > 1) {
                                      quantity--;
                                      newPrice = quantity * price;
                                      var upadateCart = FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("cart")
                                          .doc(dataCart[index]['id']);

                                      upadateCart.update({
                                        'quantity': quantity,
                                        'quantityPrice': newPrice
                                      });
                                    }

                                    // int newPrice = quantity * price;
                                  });
                                },
                                child: Image.asset(
                                  "assets/icon/icon_min.png",
                                  width: 25,
                                  color: priceColor,
                                ),
                              ),

                              //KUANTITASS
                              Text(
                                '${dataCart[index]['quantity']}',
                                style: titleTextStyle.copyWith(
                                    fontSize: 18, fontWeight: semiBold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    int quantity = dataCart[index]['quantity'];
                                    int price = dataCart[index]['harga'];
                                    quantity++;
                                    newPrice = quantity * price;
                                    var upadate = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("cart")
                                        .doc(dataCart[index]['id']);

                                    upadate.update({
                                      'quantity': quantity,
                                      'quantityPrice': newPrice,
                                      'cQP': 0
                                    });
                                  });
                                },
                                child: Image.asset(
                                  "assets/icon/icon_max.png",
                                  width: 25,
                                  color: priceColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      );
    }

    Widget getDataCart() {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('cart')
            .where('idResto', isEqualTo: dataMeja['idResto'])
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
            return emptyCart();
          }

          dynamic dataCart = snapshot.data?.docs;
          int? countCart = snapshot.data?.docs.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCart(dataCart, countCart!),
              costumBottomNav(dataCart, countCart)
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          "Cart",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      // bottomNavigationBar: costumBottomNav(),
      body: getDataCart(),
    );
  }
}
