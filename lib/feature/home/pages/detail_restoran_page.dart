import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';
import '../../../presentation/card/product_card_home.dart';

class DetailRestoran extends StatefulWidget {
  final String idResto;
  const DetailRestoran(this.idResto, {Key? key}) : super(key: key);

  @override
  State<DetailRestoran> createState() => _DetailRestoranState();
}

class _DetailRestoranState extends State<DetailRestoran> {
  ScrollController controller = ScrollController();
  var firestoreInstance = FirebaseFirestore.instance;
  List dataResto = [];
  List menu = [];

  fetchMenu() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("menu")
        .where('idResto', isEqualTo: widget.idResto)
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        menu.add({
          "id": qn.docs[i]["id"],
          "nama": qn.docs[i]["nama"],
          "kategori": qn.docs[i]["kategori"],
          "harga": (qn.docs[i]["harga"].toString()),
          "imageUrl": qn.docs[i]["imageUrl"],
          "rating": qn.docs[i]["rating"],
          "countRating": qn.docs[i]["countRating"],
        });
      }
    });

    return qn.docs;
  }

  fetchRestaurant() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("restaurants")
        .where('id', isEqualTo: widget.idResto)
        .get();
    setState(() {
      dataResto.add({
        "id": qn.docs[0]["id"],
        "idUser": qn.docs[0]["idUser"],
        "name": qn.docs[0]["name"],
        "alamat": qn.docs[0]["alamat"],
        "imageUrl": qn.docs[0]["imageUrl"],
      });
    });

    return qn.docs;
  }

  String? idResto;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      fetchMenu();
      fetchRestaurant();
    });

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
                        dataResto[0]['imageUrl'],
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    dataResto[0]['name'],
                    style: titleTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(dataResto[0]['alamat'],
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
      backgroundColor: secondaryColor,
      body: dataResto.isNotEmpty
          ? ListView(
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
