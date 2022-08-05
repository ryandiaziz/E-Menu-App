import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/resto_cart%20.dart';
import 'package:e_menu_app/presentation/pages/home/detail_restoran_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import '../../../widgets/drawer.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ScrollController controller = ScrollController();
  List<String> carouselImages = [];
  List restaurants = [];
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

  @override
  void initState() {
    fetchCarouselImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTitle() {
      return Container(
        margin: const EdgeInsets.all(20),
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
                  builder: (_) => NavigationPage(
                    idMeja: 'MshMTcmisf6TNsZo2JMw',
                  ),
                ),
              );
            },
            child: const Icon(Icons.menu_book),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/onboarding-page");
            },
            child: const Icon(Icons.logout),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        backgroundColor: priceColor,
        onPressed: () {
          Navigator.pushNamed(context, '/qrscan');
        },
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AspectRatio(
                aspectRatio: 2.6 / 1.6,
                child: CarouselSlider(
                  items: carouselImages
                      .map(
                        (item) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(
                        () {
                          dotPosition = val;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DotsIndicator(
              dotsCount: carouselImages.isEmpty ? 1 : carouselImages.length,
              position: dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: priceColor,
                color: priceColor.withOpacity(0.5),
                spacing: const EdgeInsets.all(2),
                activeSize: const Size(8, 8),
                size: const Size(6, 6),
              ),
            ),
            buildTitle(),
            getResto()
          ],
        ),
      ),
    );
  }
}
