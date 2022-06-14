import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

Widget qrcodemenu(BuildContext context, ScrollController controller) {
  return StaggeredGridView.countBuilder(
    controller: controller,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    staggeredTileBuilder: (context) => const StaggeredTile.count(2, 3.5),
    // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    itemCount: 8,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    itemBuilder: (context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        // margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          // border: Border.all(color: priceColor, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.asset(
                'assets/img/qcode.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Meja No. 5",
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                    SizedBox(
                      height: 40,
                      width: 180,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/checkout");
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: priceColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "Cetak",
                            style: secondaryTextStyle.copyWith(
                                fontSize: 18, fontWeight: semiBold),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                      width: 180,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/checkout");
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: priceColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "Hapus",
                            style: secondaryTextStyle.copyWith(
                                fontSize: 18, fontWeight: semiBold),
                          )),
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
