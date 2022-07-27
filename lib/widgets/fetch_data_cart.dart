import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';

Widget fetchData(String collectionName) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("cart")
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

            return Container(
              margin: const EdgeInsets.only(
                left: 10,
                bottom: 5,
                top: 5,
                right: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: secondaryColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Baris 1
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
                                    _documentSnapshot['imageUrl']))),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _documentSnapshot['name'],
                              style: primaryTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              _documentSnapshot['kategori'],
                              style: secondSubtitleTextStyle.copyWith(
                                  fontWeight: regular, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              _documentSnapshot['harga'],
                              style: priceTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection(collectionName)
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("cart")
                              .doc(_documentSnapshot.id)
                              .delete();
                        },
                        child: Image.asset(
                          "assets/icon/icon_remove.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 35,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xffEFF0F6),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                "assets/icon/icon_min.png",
                                width: 25,
                                color: priceColor,
                              ),
                            ),
                            Text(
                              "i",
                              style: titleTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                "assets/icon/icon_max.png",
                                width: 25,
                                color: priceColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          });
    },
  );
}
