import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/pages/home/navigation.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:intl/intl.dart';
// import 'package:e_menu_app/presentation/card/product_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'menu_kategori.dart';

class MenuPage extends StatefulWidget {
  dynamic dataMeja;
  MenuPage({this.dataMeja, Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState(dataMeja);
}

class _MenuPageState extends State<MenuPage> {
  dynamic dataMeja;
  _MenuPageState(this.dataMeja);
  ScrollController controller = ScrollController();
  var firestoreInstance = FirebaseFirestore.instance;
  List menu = [];
  List resto = [];
  // List meja = [];
  String? namaResto;
  String? imgResto;

  String? idPesanan;
  int kuantitas = 1;

  fetchMenu() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("menu")
        .where('idResto', isEqualTo: dataMeja['idResto'])
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        menu.add({
          "id": qn.docs[i]["id"],
          "nama": qn.docs[i]["nama"],
          "kategori": qn.docs[i]["kategori"],
          "harga": qn.docs[i]["harga"].toString(),
          "imageUrl": qn.docs[i]["imageUrl"],
        });
      }
    });

    return qn.docs;
  }

  fetchRestaurant() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("restaurants")
        .where('id', isEqualTo: dataMeja['idResto'])
        .get();
    setState(() {
      resto.add({
        "id": qn.docs[0]["id"],
        "idUser": qn.docs[0]["idUser"],
        "name": qn.docs[0]["name"],
        "alamat": qn.docs[0]["alamat"],
        "imageUrl": qn.docs[0]["imageUrl"],
      });
      namaResto = resto[0]['name'];
      imgResto = resto[0]['imageUrl'];
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchMenu();
    fetchRestaurant();
    super.initState();
  }

  Future addToCart(menu) async {
    QuerySnapshot checkMenuRating = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('cart')
        .where('idMenu', isEqualTo: menu['id'])
        .get();

    QuerySnapshot checkTotal = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('total')
        .where('idResto', isEqualTo: dataMeja['idResto'])
        .get();

    if (checkMenuRating.docs.isEmpty) {
      final docCart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc();
      final docTotal = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('total')
          .doc();

      await docCart.set({
        'id': docCart.id,
        "noMeja": dataMeja['noMeja'],
        "idResto": dataMeja['idResto'],
        "namaResto": namaResto,
        "imgResto": imgResto,
        "name": menu['nama'],
        "hargaAsli": int.parse(menu['harga']),
        "harga": int.parse(menu['harga']),
        "kategori": menu["kategori"],
        "imageUrl": menu["imageUrl"],
        'idMenu': menu['id'],
        "quantity": 1,
        "cQP": null,
        "quantityPrice": 0,
      });
    } else {
      final docCart = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('cart')
          .doc(checkMenuRating.docs[0]['id']);
      await docCart.update({
        'cQP': 0,
        'quantity': checkMenuRating.docs[0]['quantity'] + 1,
        'quantityPrice':
            checkMenuRating.docs[0]['quantityPrice'] + int.parse(menu['harga'])
      });
    }
  }

  void tambahKuantitas() {
    setState(() {
      kuantitas++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget titleCatagories() {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
          ),
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Categories",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
    }

    Widget scrollCategories(text) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              height: 40,
              decoration: BoxDecoration(
                color: priceColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Text(
                text,
                style:
                    secondaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      );
    }

    Widget bottomSheetDetail(menu) {
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
                    menu["imageUrl"],
                    width: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        menu["nama"],
                        style: titleTextStyle.copyWith(
                            fontSize: 22, fontWeight: bold),
                      ),
                      Text(
                        menu["kategori"],
                        style: subtitleTextStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(int.parse(menu["harga"])),
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
                      addToCart(menu);
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

    Widget product(menu) {
      return StaggeredGridView.countBuilder(
        controller: controller,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        staggeredTileBuilder: (context) => const StaggeredTile.count(2, 2.9),
        // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        itemCount: menu.length,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // mySheet(menu[index]);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (builder) => bottomSheetDetail(menu[index]),
              );
            },
            child: Container(
              // margin: const EdgeInsets.only(left: 5, right: 5),
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
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Image.network(
                      menu[index]["imageUrl"],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
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
                            menu[index]["nama"],
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
                            ).format(int.parse(menu[index]["harga"])),
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
                                style: titleTextStyle.copyWith(fontSize: 12),
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
        leading: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Icon(
              Icons.bookmark,
              color: secondsubtitleColor,
              size: 50,
            ),
            Positioned(
              bottom: 19,
              right: 19,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: Text(
                    dataMeja['noMeja'],
                    style: subtitleTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        title: Text(
          "Menu",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.search_rounded,
        //         color: secondsubtitleColor,
        //         size: 35,
        //       )),
        //   const SizedBox(
        //     width: 5,
        //   )
        // ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // Text(namaResto ?? ''),
          titleCatagories(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  //KATEGORI
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenuKategoriPage(
                            dataMeja: dataMeja,
                            kategori: 'Makanan',
                            imgResto: imgResto,
                            namaResto: namaResto,
                          ),
                        ),
                      );
                    },
                    child: scrollCategories(
                      // "assets/img/image_burger.png",
                      "Makanan",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenuKategoriPage(
                            dataMeja: dataMeja,
                            kategori: 'Minuman',
                            imgResto: imgResto,
                            namaResto: namaResto,
                          ),
                        ),
                      );
                    },
                    child: scrollCategories(
                      // "assets/icon/icon_sandwich.png",
                      "Minuman",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenuKategoriPage(
                            dataMeja: dataMeja,
                            kategori: 'Cemilan',
                            imgResto: imgResto,
                            namaResto: namaResto,
                          ),
                        ),
                      );
                    },
                    child: scrollCategories(
                      // "assets/img/image_burger.png",
                      "Cemilan",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: product(menu),
          )
        ],
      ),
    );
  }
}
