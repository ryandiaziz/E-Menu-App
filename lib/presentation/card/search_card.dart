import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../pages/home/detail_restoran_page.dart';

class SearchCard extends StatefulWidget {
  final dynamic data;
  const SearchCard({this.data, Key? key}) : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  var firestoreInstance = FirebaseFirestore.instance;
  // List menu = [];
  List resto = [];
  double? rating;

  fetchResto(String idResto) async {
    QuerySnapshot qn = await firestoreInstance
        .collection("restaurants")
        .where('id', isEqualTo: idResto)
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        resto.add({
          "id": qn.docs[i]["id"],
          "nama": qn.docs[i]["name"],
          "kategori": qn.docs[i]["alamat"],
          "imageUrl": qn.docs[i]["imageUrl"],
          "idUser": qn.docs[i]["idUser"],
        });
      }
    });

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await fetchResto(widget.data['idResto']);
        print(resto);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailRestoran(widget.data['idResto']),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        widget.data['imageUrl'],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.data['nama'],
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format((widget.data["harga"])),
                      style: priceTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold)),
                  const SizedBox(
                    height: 3,
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
                        '${widget.data["rating"]}',
                        style: titleTextStyle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(by ${widget.data["countRating"]} users)',
                        style: titleTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  // Text(
                  //   '${widget.data['rating']}',
                  //   style: subtitleTextStyle.copyWith(
                  //       fontSize: 12, fontWeight: regular),
                  // ),
                  const SizedBox(
                    height: 3,
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
