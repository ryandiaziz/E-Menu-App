import 'package:e_menu_app/presentation/card/qrcode_card.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class MejaPage extends StatefulWidget {
  const MejaPage({Key? key}) : super(key: key);

  @override
  State<MejaPage> createState() => _MejaPageState();
}

class _MejaPageState extends State<MejaPage> {
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
            "Meja Saya",
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
              qrcodemenu(context, controller),
            ],
          ),
        ));
  }
}
