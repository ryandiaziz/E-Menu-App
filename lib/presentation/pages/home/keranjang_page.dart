import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:intl/intl.dart';

class BagPage extends StatefulWidget {
  dynamic dataMeja;

  BagPage({this.dataMeja, Key? key}) : super(key: key);
  @override
  State<BagPage> createState() => _BagPageState(dataMeja);
}

class _BagPageState extends State<BagPage> {
  int? newPrice;
  dynamic dataMeja;
  List dataCart = [];
  _BagPageState(this.dataMeja);
  String? idCheckout;
  int? harga;
  int totalHarga = 0;
  String? idOrder;

  Future addOrder(dynamic dataCart, int countCart) async {
    var docOrder = FirebaseFirestore.instance.collection('order').doc();

    for (var i = 0; i < countCart; i++) {
      setState(() {
        dataCart[i]['quantityPrice'] == null
            ? harga = dataCart[i]['harga']
            : harga = dataCart[i]['quantityPrice'];
        totalHarga = totalHarga + harga!;
      });
    }

    await docOrder.set({
      "id": docOrder.id,
      "pemesan": FirebaseAuth.instance.currentUser!.email,
      "total": totalHarga,
      "date": DateTime.now(),
      "noMeja": dataCart[0]['noMeja'],
      "idResto": dataCart[0]['idResto'],
      "namaResto": dataCart[0]['namaResto'],
    });

    setState(() {
      idOrder = docOrder.id;
      harga = 0;
      totalHarga = 0;
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
        "harga": dataCart[i]['quantityPrice'] == null
            ? dataCart[i]['harga']
            : dataCart[i]['quantityPrice'],
        "kuantitas": dataCart[i]['quantity'],
        "kategori": dataCart[i]["kategori"],
        "imageUrl": dataCart[i]["imageUrl"],
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

  @override
  Widget build(BuildContext context) {
    Widget bottomSheetCheckout() {
      return Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            const Text("Pilih Foto"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop;
                        // getImage(ImageSource.camera);
                      },
                      child: const Icon(Icons.camera),
                    ),
                    const Text('Kamera')
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        // await getImage(ImageSource.gallery);
                        // await _upload('${image?.path}');
                      },
                      child: const Icon(Icons.image),
                    ),
                    const Text('Galeri')
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    Widget costumBottomNav(dynamic dataCart, int countCart) {
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
                  "Total",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                // ElevatedButton(onPressed: () {}, child: Text('dataCart'))
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                  onPressed: () async {
                    // print(countCart);
                    await addOrder(dataCart, countCart);
                    await addItemsToOrder(dataCart, countCart);
                    await deleteCart(dataCart, countCart);
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: const Text('Menu Dihapus'),
                    //   backgroundColor: alertColor,
                    // ));
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (builder) => bottomSheetCheckout(),
                    // );
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
            )
          ],
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
                              dataCart[index]['quantityPrice'] == null
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
                              Text(
                                dataCart[index]['id'],
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
                                      'quantityPrice': newPrice
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
          dynamic dataCart = snapshot.data?.docs;
          int? countCart = snapshot.data?.docs.length;

          if (dataCart == null) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
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
        elevation: 0,
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
