import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/customer/profile_cus_page.dart';
import 'package:e_menu_app/presentation/pages/home/home_page.dart';
import 'package:e_menu_app/widgets/cus_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/pages/home/keranjang_page.dart';
import 'package:e_menu_app/presentation/pages/home/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_menu_app/presentation/pages/home/riwayat_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationPage extends StatefulWidget {
  String idMeja;
  NavigationPage({required this.idMeja, Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState(idMeja);
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  String idMeja;
  _NavigationPageState(this.idMeja);

  // final screens = [
  //   MenuPage(idMeja: idMeja),
  //   BagPage(),
  // ];

  Widget indicator() {
    return Container(
      width: 32,
      height: 4,
      decoration: BoxDecoration(
          color: priceColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          )),
    );
  }

  Widget body(dataMeja, dataUser) {
    switch (index) {
      case 0:
        return MenuPage(
          dataMeja: dataMeja,
        );
      case 1:
        return BagPage(
          dataMeja: dataMeja,
          dataUser: dataUser,
        );
      default:
        return MenuPage(
          dataMeja: dataMeja,
        );
    }
  }

  Widget customBottomNav() {
    return BottomNavigationBar(
      backgroundColor: secondaryColor,
      currentIndex: index,
      onTap: (value) {
        setState(() {
          index = value;
        });
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedItemColor: Colors.grey,
      selectedItemColor: priceColor,
      selectedLabelStyle: GoogleFonts.roboto(fontSize: 12, fontWeight: regular),
      unselectedLabelStyle:
          GoogleFonts.roboto(fontSize: 12, fontWeight: regular),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          label: "Menu",
          icon: Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: Column(
              children: const [
                Icon(
                  CupertinoIcons.book,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Keranjang",
          icon: Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: Column(
              children: const [
                Icon(
                  CupertinoIcons.shopping_cart,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getUser(dynamic dataMeja) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        dynamic dataUser = snapshot.data?.docs;

        if (dataUser == null) {
          return Center(
            child: CircularProgressIndicator(
              color: priceColor,
            ),
          );
        }
        return body(dataMeja, dataUser);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      bottomNavigationBar: customBottomNav(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tables')
            .doc(idMeja)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var dataMeja = snapshot.data;
          if (dataMeja == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return getUser(dataMeja);
        },
      ),
      // body()
      // appBar: CusAppBar(),
    );
  }
}
