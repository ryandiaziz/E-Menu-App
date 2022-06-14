import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

Widget menuadmin(BuildContext context, ScrollController controller) {
  return StaggeredGridView.countBuilder(
    controller: controller,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    staggeredTileBuilder: (context) => const StaggeredTile.count(2, 3.4),
    // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    itemCount: 8,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nasi Goreng",
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                    Text("Rp 22.000",
                        style: priceTextStyle.copyWith(
                            fontSize: 14, fontWeight: bold)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            width: 100,
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, "/checkout");
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: priceColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  "Edit",
                                  style: secondaryTextStyle.copyWith(
                                      fontSize: 18, fontWeight: semiBold),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red.shade200)),
                            child: Image.asset(
                              "assets/icon/icon_remove.png",
                              width: 12,
                            ),
                          ),
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
