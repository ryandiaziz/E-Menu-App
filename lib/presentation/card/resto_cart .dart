import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class RestoCard extends StatefulWidget {
  final dynamic dataResto;
  const RestoCard({this.dataResto, Key? key}) : super(key: key);

  @override
  State<RestoCard> createState() => _RestoCardState();
}

class _RestoCardState extends State<RestoCard> {
  double? rating;
  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(
                      widget.dataResto['imageUrl'],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.dataResto['name'],
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.dataResto['alamat'],
                  style: subtitleTextStyle.copyWith(
                      fontSize: 12, fontWeight: regular),
                ),
                const SizedBox(
                  height: 3,
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
