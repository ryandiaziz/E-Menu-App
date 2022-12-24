import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/pemilik/graphic_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'edit_menu_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController controller = ScrollController();

  Future addItemsToOrder(dynamic dataCart, int countCart) async {
    for (var i = 0; i < countCart; i++) {
      var docCheckout =
          FirebaseFirestore.instance.collection('menu').doc(dataCart[i]['id']);

      docCheckout.set({
        "id": dataCart[i]['id'],
        "nama": dataCart[i]['nama'],
        "harga": dataCart[i]['harga'],
        "kategori": dataCart[i]["kategori"],
        "imageUrl": dataCart[i]["imageUrl"],
        "idResto": dataCart[i]['idResto'],
      });
    }

    // Navigator.pushReplacementNamed(context, '/profile-ad');
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: const Text('Daftar Berhasil'),
    //   backgroundColor: priceColor,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    String idResto = ModalRoute.of(context)!.settings.arguments as String;

    Widget buildMenu(dataMenu, countMenu) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StaggeredGridView.countBuilder(
            controller: controller,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (context) =>
                const StaggeredTile.count(2, 2.9),
            // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            crossAxisCount: 4,
            itemCount: countMenu,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // mySheet(menu[index]);
                  // showModalBottomSheet(
                  //   isScrollControlled: true,
                  //   context: context,
                  //   builder: (builder) => bottomSheetDetail(menu[index]),
                  // );
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: Image.network(
                              dataMenu[index]["imageUrl"],
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditMenu(
                                    dataMenu: dataMenu[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: priceColor,
                              ),
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 70,
                              child: GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('menu')
                                      .doc(dataMenu[index]['id'])
                                      .delete();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: alertColor,
                                  ),
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataMenu[index]["nama"],
                                style: titleTextStyle.copyWith(
                                    fontSize: 18, fontWeight: bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(
                                  (dataMenu[index]['harga']),
                                ),
                                style: priceTextStyle.copyWith(
                                    fontWeight: semiBold, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
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
                                    '${dataMenu[index]['rating']}',
                                    style:
                                        titleTextStyle.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(by ${dataMenu[index]["countRating"]} users)',
                                    style:
                                        titleTextStyle.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }

    Widget getMenu() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("menu")
            .where('idResto', isEqualTo: idResto)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }

          var dataMenu = snapshot.data?.docs;
          var countMenu = snapshot.data?.docs.length;

          if (dataMenu == null) {
            return const Center(
              child: Text(
                'No data',
              ),
            );
          }
          return buildMenu(dataMenu, countMenu);
        },
      );
    }

    //
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChartPage(idResto),
                  ),
                );
              },
              child: Icon(
                CupertinoIcons.graph_circle_fill,
                color: secondsubtitleColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
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
          automaticallyImplyLeading: true,
          titleSpacing: -5,
          elevation: 1,
          title: Text(
            'Menu Saya',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: getMenu());
  }
}
