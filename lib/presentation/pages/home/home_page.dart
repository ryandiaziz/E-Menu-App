import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/shared/theme.dart';

import '../../../models/restaurant_model.dart';
import '../../../widgets/drawer.dart';
import '../../card/list_restoran_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=449&q=80',
      'https://images.unsplash.com/photo-1515516969-d4008cc6241a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      'https://images.unsplash.com/photo-1612927601601-6638404737ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      'https://images.unsplash.com/photo-1603133872878-684f208fb84b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
    ];

    final List<Widget> imageSliders = imgList
        .map(
          (item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
        .toList();

    Widget buildTitle() {
      return Container(
        margin: const EdgeInsets.only(right: 10, left: 10, top: 20),
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
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
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
                Navigator.pushNamed(context, '/navigation-page');
              },
              child: const Icon(Icons.menu_book),
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
            Navigator.pushNamed(context, '/scan-page');
          },
        ),
        drawer: NavigationDrawer(),
        body: StreamBuilder<List<Restaurant>>(
            stream: readRestaurant(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // return Text('${snapshot.error}');
                return Text("Something went wrong! ${snapshot.error}");
              } else if (snapshot.hasData) {
                final restaurants = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            initialPage: 2,
                            autoPlay: true,
                          ),
                          items: imageSliders,
                        ),
                      ),
                      buildTitle(),
                      Column(
                        children: restaurants.map(buildRestaurant).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // return ListView(
              //   children: [
              //     search(),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pushNamed(context, '/detail-restoran');
              //       },
              //       child: RestoranCard(),
              //     ),
              //     RestoranCard(),
              //     RestoranCard(),
              //     RestoranCard(),
              //   ],
              // );
            }));
  }

  Stream<List<Restaurant>> readRestaurant() => FirebaseFirestore.instance
      .collection('users')
      .doc('ppbQ5c1RS0R6I5rtC6a9k0b22OY2')
      .collection('reso')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Restaurant.fromJson(doc.data())).toList());
}
