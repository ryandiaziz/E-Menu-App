import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../pages/home/detail_restoran_page.dart';

Widget restaurant(
  BuildContext context,
  ScrollController controller,
  List restaurants,
) {
  return StaggeredGridView.countBuilder(
    controller: controller,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    staggeredTileBuilder: (context) => const StaggeredTile.count(3, 1.2),
    // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 3,
    itemCount: restaurants.length,
    crossAxisSpacing: 10,
    mainAxisSpacing: 20,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailRestoran(restaurants[index]['id']),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(
            // top: 10,
            bottom: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            image:
                                NetworkImage(restaurants[index]['imageUrl']))),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurants[index]['name'],
                        style: primaryTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        restaurants[index]['alamat'],
                        style: subtitleTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

mySheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(
            // top: 10,
            top: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            color: secondaryColor,
          ),
          child: Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Baris 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icon/icon_star.png",
                          width: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "4.8",
                          style: titleTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(41 Reviews)",
                          style: titleTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
                //Baris 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/img/image_nasgor.jpg",
                      width: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Nasi Goreng",
                          style: titleTextStyle.copyWith(
                              fontSize: 24, fontWeight: bold),
                        ),
                        Text("Makanan",
                            style: subtitleTextStyle.copyWith(fontSize: 18)),
                        Text(
                          "Rp22.00",
                          style: priceTextStyle.copyWith(
                              fontSize: 24, fontWeight: bold),
                        ),
                      ],
                    ),
                  ],
                ),
                //Bariis 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFF0F6),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/icon/icon_min.png",
                              width: 25,
                              color: priceColor,
                            ),
                            Text(
                              "1",
                              style: titleTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                            Image.asset(
                              "assets/icon/icon_max.png",
                              width: 25,
                              color: priceColor,
                            ),
                          ]),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: priceColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      onPressed: () {},
                      child: Text(
                        "Tambahkan ke Keranjang",
                        style: secondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      )),
                )
              ],
            ),
          ),
        );
      });
}
