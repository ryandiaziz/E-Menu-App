import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

Widget product(BuildContext context, ScrollController controller) {
  return StaggeredGridView.countBuilder(
    controller: controller,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    staggeredTileBuilder: (context) => const StaggeredTile.count(2, 2.9),
    // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    itemCount: 8,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    itemBuilder: (context, index) {
      return Container(
        // margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          // border: Border.all(color: priceColor, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.asset(
                'assets/img/image_nasgor.jpg',
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
                      "Chicken burger",
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Rp 22.000",
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
                          "4.8",
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
  );
}
