import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/resto_cart%20.dart';
import 'package:e_menu_app/presentation/pages/home/detail_restoran_page.dart';
import 'package:e_menu_app/presentation/pages/home/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import '../../../widgets/drawer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ScrollController controller = ScrollController();
  List<String> carouselImages = [];
  List<String>? carouselRekom = [];
  List restaurants = [];
  List rekomendasi = [];
  String? idUser;
  var firestoreInstance = FirebaseFirestore.instance;
  var dotPosition = 0;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselImages.add(
          qn.docs[i]["img-path"],
        );
        (qn.docs[i]["img-path"]);
      }
    });
    return qn.docs;
  }

  Future sendData() async {
    final url = Uri.parse("http://10.140.139.112:8000/api");
    await http.post(url, body: jsonEncode({'idUser': idUser}));
  }

  Future getRecommendations() async {
    final recommendations = await FirebaseFirestore.instance
        .collection('recommendations')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (recommendations.exists) {
      for (var i = 0; i < 5; i++) {
        final menu = await FirebaseFirestore.instance
            .collection('menu')
            .doc(recommendations['rekomendasi'][i])
            .get();
        final resto = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(menu['idResto'])
            .get();

        setState(() {
          rekomendasi.add({
            'nama': menu['nama'],
            'idResto': menu['idResto'],
            'imgUrl': menu['imageUrl'],
            'rating': menu['rating'],
            'countRating': menu['countRating'],
            'namaResto': resto['name']
          });
        });
      }
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      idUser = FirebaseAuth.instance.currentUser!.email;
      sendData();
      getRecommendations();
      fetchCarouselImages();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTitle() {
      return Container(
        margin: const EdgeInsets.only(
          left: 10,
          bottom: 10,
          right: 10,
          top: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Restaurants",
              style: titleTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/restaurant-page');
              },
              child: Text(
                "View all",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildRekom() {
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
                  builder: (_) => DetailRestoran(dataResto[index]['id']),
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

    void showLogin() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text('Login?')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('login untuk dapat melakukan proses pemesanan'),
                  SizedBox(
                    height: 20,
                  ),
                  // buildRating()
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/auntentikasi');
                    },
                    child: const Text('OK')),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: priceColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // sabri GXlT5F05zPBT9a8hDJxB
          //       // aby hZNZbzGDkuLZ3dD95L4X
          //       // rhumbia  8V3z0yVONyrhd2hRT1xY
          //       MaterialPageRoute(
          //         builder: (_) => NavigationPage(
          //           idMeja: 'hZNZbzGDkuLZ3dD95L4X',
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Icon(Icons.menu_book),
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     FirebaseAuth.instance.signOut();
          //     Navigator.pushReplacementNamed(context, "/onboarding-page");
          //   },
          //   child: const Icon(Icons.logout),
          // ),
          // const SizedBox(
          //   width: 10,
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        backgroundColor: priceColor,
        onPressed: () {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            Navigator.pushNamed(context, '/qrscan');
          } else {
            showLogin();
          }
        },
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       sendData();
            //       getRecommendations();
            //     },
            //     child: Text('Cek')),
            rekomendasi.isNotEmpty ? buildRekom() : const SizedBox(),
            buildTitle(),
            getResto(),
          ],
        ),
      ),
    );
  }
}
