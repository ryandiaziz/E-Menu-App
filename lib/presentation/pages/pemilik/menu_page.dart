import 'package:e_menu_app/presentation/card/menu_card.dart';
import 'package:e_menu_app/presentation/card/product_card.dart';
import 'package:e_menu_app/presentation/card/qrcode_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
            "Menu Saya",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              menuadmin(context, controller),
            ],
          ),
        ));
  }
}
