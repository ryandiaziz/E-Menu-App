import 'package:flutter/material.dart';
import '../../models/restaurant_model.dart';
import '../../shared/theme.dart';

Widget buildRestaurant(Restaurant restaurant) => Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            restaurant.imageUrl,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
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
                SizedBox(
                  // child: Text(restaurant.idUser),
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
