import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:e_menu_app/presentation/pages/home/menu_page.dart';

int kuantitas = 5;

Widget productHome(
  BuildContext context,
  ScrollController controller,
  List menu,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: StaggeredGridView.countBuilder(
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
        return Container(
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
                      Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(int.parse(menu[index]["harga"])),
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
                            '${menu[index]["rating"]}',
                            style: titleTextStyle.copyWith(fontSize: 12),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(by ${menu[index]["countRating"]} users)',
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
        );
      },
    ),
  );
}
