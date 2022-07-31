import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class OrderCardOwner extends StatefulWidget {
  dynamic dataOrder;
  OrderCardOwner({this.dataOrder, Key? key}) : super(key: key);

  @override
  State<OrderCardOwner> createState() => _OrderCardOwnerState();
}

class _OrderCardOwnerState extends State<OrderCardOwner> {
  double? rating;
  @override
  Widget build(BuildContext context) {
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
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/img/image_profile_user.png",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dataOrder['namaPemesan'],
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.dataOrder['date'].toString(),
                    style: subtitleTextStyle.copyWith(
                        fontSize: 12, fontWeight: regular),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.dataOrder['totalItems']}",
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
                  Container(
                    // width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFF0F6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: widget.dataOrder['status'] == false
                            ? Text(
                                "Pesanan sedang diproses",
                                style: alertTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              )
                            : Text(
                                "Pesanan Selesai",
                                style: priceTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              )),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
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
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(
                  (widget.dataOrder['totalHarga']),
                ),
                style:
                    priceTextStyle.copyWith(fontWeight: semiBold, fontSize: 14),
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
