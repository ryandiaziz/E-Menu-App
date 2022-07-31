import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ItemsCardCus extends StatefulWidget {
  dynamic dataItems;
  ItemsCardCus({this.dataItems, Key? key}) : super(key: key);

  @override
  State<ItemsCardCus> createState() => _ItemsCardCusState();
}

class _ItemsCardCusState extends State<ItemsCardCus> {
  double? rating;
  @override
  Widget build(BuildContext context) {
    Widget buildRating() {
      return RatingBar.builder(
        initialRating: rating ?? 0,
        minRating: 1,
        itemSize: 35,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        onRatingUpdate: (rating) => setState(
          () {
            this.rating = rating;
          },
        ),
      );
    }

    void showRating() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Rate This Menu'),
              content: Column(
                children: [
                  const Text('Please leave a star rating'),
                  const SizedBox(
                    height: 32,
                  ),
                  // buildRating()
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ));

    return Container(
      margin: const EdgeInsets.only(
        // top: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dataItems['nama'],
            style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(widget.dataItems['imageUrl']))),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '',
                        style: primaryTextStyle.copyWith(fontWeight: semiBold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Items",
                        style: primaryTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '',
                    style: subtitleTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Makanan",
                    style: secondSubtitleTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        "2 x",
                        style: primaryTextStyle.copyWith(fontWeight: regular),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Rp 12.000",
                        style: priceTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              rating != null
                  ? Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('$rating'),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        showRating();
                      },
                      child: Container(
                        width: 47,
                        decoration: BoxDecoration(
                          // border: Border.all(color: priceColor, width: 0.5),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: secondsubtitleColor,
                        ),
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                          bottom: 5,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            Text('rate',
                                style: secondaryTextStyle.copyWith(
                                    fontSize: 12, fontWeight: bold)),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColor.placeholder.withOpacity(0.25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: primaryTextStyle.copyWith(fontWeight: regular),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '',
                style: primaryTextStyle.copyWith(fontWeight: regular),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColor.placeholder.withOpacity(0.25),
          ),
        ],
      ),
    );
  }
}
