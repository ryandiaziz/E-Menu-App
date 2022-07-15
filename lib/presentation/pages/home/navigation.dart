import 'package:e_menu_app/presentation/pages/customer/profile_cus_page.dart';
import 'package:e_menu_app/presentation/pages/home/home_page.dart';
import 'package:e_menu_app/widgets/cus_appbar.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/pages/home/keranjang_page.dart';
import 'package:e_menu_app/presentation/pages/home/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_menu_app/presentation/pages/home/riwayat_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;

  final screens = [
    MenuPage(),
    BagPage(),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      bottomNavigationBar: customBottomNav(),
      body: screens[index],
      // appBar: CusAppBar(),
    );
  }
}
