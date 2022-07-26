import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/menu_card.dart';
import 'package:e_menu_app/presentation/card/product_card.dart';
import 'package:e_menu_app/presentation/card/qrcode_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../../models/menu_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String idResto = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: backgroundColor3,
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
        elevation: 0,
        title: Text(
          idResto,
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: StreamBuilder<List<Menu>>(
        stream: readMenu(idResto),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something Went Wrong');
          } else if (snapshot.hasData) {
            final menu = snapshot.data!;
            return Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: ListView(
                children: menu.map(menuadmin).toList(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Stream<List<Menu>> readMenu(String idResto) => FirebaseFirestore.instance
      .collection('restaurants')
      .doc(idResto)
      .collection('menu')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Menu.fromJson(doc.data())).toList());
}
