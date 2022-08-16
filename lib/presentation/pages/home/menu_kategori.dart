import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../pemilik/edit_menu_page.dart';

class MenuKategoriPage extends StatefulWidget {
  final dynamic dataMeja;
  final String? kategori;
  final String? namaResto;
  final String? imgResto;
  const MenuKategoriPage({
    this.dataMeja,
    this.kategori,
    this.namaResto,
    this.imgResto,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuKategoriPage> createState() => _MenuKategoriPageState();
}

class _MenuKategoriPageState extends State<MenuKategoriPage> {
  var firestoreInstance = FirebaseFirestore.instance;
  ScrollController controller = ScrollController();
  List menu = [];

  Future addToCart(menu) async {
    QuerySnapshot checkCart = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('cart')
        .where('idMenu', isEqualTo: menu['id'])
        .get();

    if (checkCart.docs.isEmpty) {
      final docCart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc();

      await docCart.set({
        'id': docCart.id,
        "noMeja": widget.dataMeja['noMeja'],
        "idResto": widget.dataMeja['idResto'],
        "namaResto": widget.namaResto,
        "imgResto": widget.imgResto,
        "name": menu['nama'],
        "hargaAsli": (menu['harga']),
        "harga": (menu['harga']),
        "kategori": menu["kategori"],
        "imageUrl": menu["imageUrl"],
        'idMenu': menu['id'],
        "quantity": 1,
        "quantityPrice": null,
        "cQP": null
      });
    } else {
      final docCart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc(checkCart.docs[0]['id']);
      await docCart.update({
        'quantity': checkCart.docs[0]['quantity'] + 1,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomSheetDetail(dataMenu) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: secondaryColor,
        ),
        child: Container(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Baris 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    dataMenu["imageUrl"],
                    width: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        dataMenu["nama"],
                        style: titleTextStyle.copyWith(
                            fontSize: 22, fontWeight: bold),
                      ),
                      Text(
                        dataMenu["kategori"],
                        style: subtitleTextStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(
                          (dataMenu["harga"]),
                        ),
                        style: priceTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 40,
                ),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: priceColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      Navigator.pop(context);
                      addToCart(dataMenu);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        content: const Text('Ditambahkan Ke Keranjang'),
                        backgroundColor: priceColor,
                      ));
                    },
                    child: Text(
                      "Tambahkan ke Keranjang",
                      style: secondaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                    )),
              )
            ],
          ),
        ),
      );
    }

    Widget buildMenu(dataMenu, countMenu) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StaggeredGridView.countBuilder(
            controller: controller,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (context) =>
                const StaggeredTile.count(2, 2.9),
            // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            crossAxisCount: 4,
            itemCount: countMenu,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (builder) => bottomSheetDetail(dataMenu[index]),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: Image.network(
                              dataMenu[index]["imageUrl"],
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataMenu[index]["nama"],
                                style: titleTextStyle.copyWith(
                                    fontSize: 18, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(
                                  (dataMenu[index]['harga']),
                                ),
                                style: priceTextStyle.copyWith(
                                    fontWeight: semiBold, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icon/icon_star.png",
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "4.8",
                                    style:
                                        titleTextStyle.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }

    Widget getMenu() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("menu")
            .where('idResto', isEqualTo: widget.dataMeja['idResto'])
            .where('kategori', isEqualTo: widget.kategori)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }

          var dataMenu = snapshot.data?.docs;
          var countMenu = snapshot.data?.docs.length;

          if (dataMenu == null) {
            return const Center(
              child: Text(
                'No data',
              ),
            );
          }
          return buildMenu(dataMenu, countMenu);
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
          widget.kategori!,
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: getMenu(),
    );
  }
}
