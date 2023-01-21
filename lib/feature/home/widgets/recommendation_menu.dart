import 'package:e_menu_app/feature/home/pages/detail_restoran_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class RecommendationMenu extends StatelessWidget {
  const RecommendationMenu({
    Key? key,
    required this.rekomendasi,
  }) : super(key: key);

  final List rekomendasi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
            left: 10,
            top: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rekomendasi",
                style: titleTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: rekomendasi.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailRestoran(rekomendasi[index]['idResto']),
                    ),
                  );
                },
                child: Container(
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
                  margin: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  // padding: EdgeInsets.only(bo),
                  width: 150,
                  // height: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          rekomendasi[index]["imgUrl"],
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Text(
                        rekomendasi[index]['nama'],
                        style: titleTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                      Text(
                        rekomendasi[index]['namaResto'],
                        style: subtitleTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                      ),
                      const SizedBox(
                        height: 10,
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
                            '${rekomendasi[index]['rating']}',
                            style: titleTextStyle.copyWith(fontSize: 12),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(by ${rekomendasi[index]["countRating"]} users)',
                            style: titleTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
