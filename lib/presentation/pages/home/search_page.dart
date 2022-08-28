import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/search_card.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import 'detail_restoran_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var firestoreInstance = FirebaseFirestore.instance;
  // List menu = [];
  List resto = [];
  String name = '';

  // fetchMenu() async {
  //   QuerySnapshot qn = await firestoreInstance.collection("menu").get();
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       menu.add({
  //         "id": qn.docs[i]["id"],
  //         "nama": qn.docs[i]["nama"],
  //         "kategori": qn.docs[i]["kategori"],
  //         "harga": (qn.docs[i]["harga"].toString()),
  //         "imageUrl": qn.docs[i]["imageUrl"],
  //         "rating": qn.docs[i]["rating"],
  //         "countRating": qn.docs[i]["countRating"],
  //       });
  //     }
  //   });

  //   return qn.docs;
  // }

  // @override
  // void initState() {
  //   fetchMenu();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: priceColor,
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('menu').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (name.isEmpty) {
                      return ListTile(
                        title: Text(
                          data['nama'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${data['harga']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['imageUrl'])),
                      );
                    }
                    if (data['nama']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return SearchCard(
                        data: data,
                      );
                    }
                    return Container();
                  });
        },
      ),
    );
  }
}
