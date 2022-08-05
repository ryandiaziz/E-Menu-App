import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ItemsCardCus extends StatefulWidget {
  final String? idResto;
  final dynamic dataItems;
  const ItemsCardCus({this.dataItems, this.idResto, Key? key})
      : super(key: key);

  @override
  State<ItemsCardCus> createState() => _ItemsCardCusState(idResto);
}

class _ItemsCardCusState extends State<ItemsCardCus> {
  _ItemsCardCusState(this.idResto);
  String? idResto;
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
              title: const Center(child: Text('Rate This Menu')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Please leave a star rating'),
                  const SizedBox(
                    height: 20,
                  ),
                  buildRating()
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColor.placeholder.withOpacity(0.25),
          ),
        ),
      ),
      child: Column(
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
                        image: NetworkImage(widget.dataItems['imageUrl']))),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dataItems['nama'],
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.dataItems['kategori'],
                    style: secondSubtitleTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.dataItems['kuantitas']} x",
                        style: primaryTextStyle.copyWith(fontWeight: regular),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(
                          (widget.dataItems['hargaAsli']),
                        ),
                        style: priceTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              idResto == null
                  ? rating != null
                      ? Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Sudah dinilai'),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            showRating();
                          },
                          child: Container(
                            width: 47,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
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
                        )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SubTotal",
                style: primaryTextStyle.copyWith(fontWeight: regular),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(
                  (widget.dataItems['hargaTotal']),
                ),
                style:
                    priceTextStyle.copyWith(fontWeight: semiBold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
