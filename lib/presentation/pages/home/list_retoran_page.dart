import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/presentation/card/list_restoran_card.dart';
import 'package:e_menu_app/shared/theme.dart';

import '../../../models/restaurant_model.dart';
import '../../card/resto_cart .dart';
import 'detail_restoran_page.dart';

class ListRestoran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget search() {
      return Container(
        color: secondaryColor,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(12.5),
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: subtitleColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/icon_search.png"),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }

    Widget buildResto(dataResto, countResto) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: countResto,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailRestoran(dataResto[index]),
                ),
              );
            },
            child: RestoCard(dataResto: dataResto[index]),
          );
        },
      );
    }

    Widget getResto() {
      return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("restaurants").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }

          var dataResto = snapshot.data?.docs;
          var countResto = snapshot.data?.docs.length;

          if (dataResto == null) {
            return const Center(
              child: Text(
                'No data',
              ),
            );
          }
          return buildResto(dataResto, countResto);
        },
      );
    }

    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: secondsubtitleColor,
            ),
          ),
          actions: [
            GestureDetector(
              child: Icon(
                Icons.search_sharp,
                color: secondsubtitleColor,
                size: 25,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          automaticallyImplyLeading: true,

          titleSpacing: -5,
          elevation: 1,
          title: Text(
            "Daftar Restoran",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: getResto()
        // bottomNavigationBar: costumBottomNav(),
        );
  }
}
