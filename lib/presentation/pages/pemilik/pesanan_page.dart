import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/belum_dibuat_card.dart';
import 'package:e_menu_app/presentation/card/riwayat_pemilik_card.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

import '../../card/order_cus_cart.dart';
import '../../card/order_owner_cart.dart';
import '../customer/rincian_pesanan.dart';

class PesananPage extends StatefulWidget {
  final String idResto;
  final int index;

  const PesananPage({
    required this.idResto,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState(
        idResto,
        index,
      );
}

class _PesananPageState extends State<PesananPage> {
  _PesananPageState(
    this._idResto,
    this._index,
  );

  final String _idResto;
  final int _index;
  List<Tab> myTab = [
    const Tab(text: 'Belum dibuat'),
    const Tab(text: 'Selesai'),
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildBelumDibuat(dynamic dataOrder, int countOrder, String status) {
      return Expanded(
        child: ListView.builder(
          itemCount: countOrder,
          itemBuilder: (_, index) {
            return status == "belum"
                ? dataOrder[index]['status'] != true
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RincianPesananPage(
                                  dataOrder: dataOrder[index],
                                  idResto: _idResto),
                            ),
                          );
                        },
                        child: OrderCardOwner(
                          dataOrder: dataOrder[index],
                        ),
                      )
                    : const SizedBox()
                : dataOrder[index]['status'] == true
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RincianPesananPage(
                                  dataOrder: dataOrder[index],
                                  idResto: _idResto),
                            ),
                          );
                        },
                        child: OrderCardOwner(
                          dataOrder: dataOrder[index],
                        ),
                      )
                    : const SizedBox();
          },
        ),
      );
    }

    Widget getOrder(String status) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("order")
            .where('idResto', isEqualTo: _idResto)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          dynamic dataOrder = snapshot.data?.docs;
          int? countOrder = snapshot.data?.docs.length;

          if (dataOrder == null) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildBelumDibuat(dataOrder, countOrder!, status)

              // costumBottomNav(dataCart, countCart)
            ],
          );
        },
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: _index,
          length: myTab.length,
          child: Scaffold(
            backgroundColor: AppColor.placeholderBg,
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
              automaticallyImplyLeading: true,
              titleSpacing: -5,
              elevation: 1,
              title: Text(
                "Pesanan",
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
                // fontWeight: semiBold,
              ),
              bottom: TabBar(
                labelColor: priceColor,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 2,
                indicatorColor: priceColor,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: primaryTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 16),
                tabs: myTab,
              ),
            ),
            body: TabBarView(
              children: [
                getOrder("belum"),
                getOrder("selesai"),
              ],
            ),
          ),
        ));
  }
}
