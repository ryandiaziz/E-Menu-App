import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/card/list_restoran_card.dart';
import 'package:e_menu_app/shared/theme.dart';

class ListRestoran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget search() {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(12.5),
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: subtitleColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/icon_search.png"),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )),
            ),
            // const SizedBox(
            //   width: 16,
            // ),
            // Image.asset(
            //   "assets/icon/Icon_filter.png",
            //   width: 48,
            // )
          ],
        ),
      );
    }

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
            "Daftar Restoran",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: ListView(
          children: [
            search(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail-restoran');
              },
              child: RestoranCard(),
            ),
            RestoranCard(),
            RestoranCard(),
            RestoranCard(),
          ],
        )
        // bottomNavigationBar: costumBottomNav(),
        );
  }
}
