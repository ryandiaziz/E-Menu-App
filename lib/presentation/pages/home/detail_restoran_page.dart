import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/product_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../card/product_card_home.dart';

// ignore: must_be_immutable
class DetailRestoran extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var restaurants;
  DetailRestoran(this.restaurants, {Key? key}) : super(key: key);

  @override
  State<DetailRestoran> createState() => _DetailRestoranState();
}

class _DetailRestoranState extends State<DetailRestoran> {
  ScrollController controller = ScrollController();
  var firestoreInstance = FirebaseFirestore.instance;
  List menu = [];

  fetchMenu() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("restaurants")
        .doc(idResto)
        .collection('menu')
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        menu.add({
          "id": qn.docs[i]["id"],
          "nama": qn.docs[i]["nama"],
          "kategori": qn.docs[i]["kategori"],
          "harga": (qn.docs[i]["harga"].toString()),
          "imageUrl": qn.docs[i]["imageUrl"],
        });
      }
    });

    return qn.docs;
  }

  String? idResto;

  @override
  void initState() {
    idResto = widget.restaurants['id'];
    fetchMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: priceColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: Image.network(
                        widget.restaurants["imageUrl"],
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.restaurants["name"],
                    style: titleTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(widget.restaurants["alamat"],
                      style: secondSubtitleTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold)),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        )),
      );
    }

    return Scaffold(
        backgroundColor: AppColor.placeholderBg,
        body: ListView(
          children: [
            header(),
            const SizedBox(
              height: 10,
            ),
            productHome(
              context,
              controller,
              menu,
            ),
          ],
        ));
  }
}
