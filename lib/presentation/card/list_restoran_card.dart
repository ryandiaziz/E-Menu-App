import 'package:e_menu_app/common/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

Widget buildRestaurant(Restaurant restaurant) => Container(
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
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: Image.network(
              restaurant.imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style:
                      titleTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(restaurant.alamat,
                    style: secondSubtitleTextStyle.copyWith(
                        fontSize: 14, fontWeight: bold)),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
