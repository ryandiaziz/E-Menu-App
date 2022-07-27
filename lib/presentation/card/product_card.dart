import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:e_menu_app/presentation/pages/home/menu_page.dart';

int kuantitas = 5;

Widget product(
  BuildContext context,
  ScrollController controller,
  List menu,
) {
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
          mySheet(context, menu[index]);
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      Text(menu[index]["harga"],
                          style: priceTextStyle.copyWith(
                              fontSize: 14, fontWeight: bold)),
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

Future addToCart(menu) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users");
  return _collectionRef.doc(currentUser!.email).collection("cart").doc().set({
    "name": menu['nama'],
    "harga": menu['harga'],
    "kategori": menu["kategori"],
    "imageUrl": menu["imageUrl"],
  }).then((value) => ("Added to cart"));
}

mySheet(BuildContext context, menu) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(
            // top: 10,
            top: 10,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Baris 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icon/icon_star.png",
                          width: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "4.8",
                          style: titleTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(41 Reviews)",
                          style: titleTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
                //Baris 2
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
                              fontSize: 24, fontWeight: bold),
                        ),
                        Text(
                          menu["kategori"],
                          style: subtitleTextStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          menu["harga"],
                          style: priceTextStyle.copyWith(
                              fontSize: 24, fontWeight: bold),
                        ),
                      ],
                    ),
                  ],
                ),
                //Bariis 3
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
                                kuantitas++;
                              },
                              child: Image.asset(
                                "assets/icon/icon_min.png",
                                width: 25,
                                color: priceColor,
                              ),
                            ),
                            Text(
                              kuantitas.toString(),
                              style: titleTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                            Image.asset(
                              "assets/icon/icon_max.png",
                              width: 25,
                              color: priceColor,
                            ),
                          ]),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: priceColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      onPressed: () {
                        addToCart(menu);
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
      });
}
