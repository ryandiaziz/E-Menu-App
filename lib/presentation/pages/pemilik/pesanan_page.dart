import 'package:e_menu_app/presentation/card/belum_dibuat_card.dart';
import 'package:e_menu_app/presentation/card/riwayat_pemilik_card.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  List<Tab> myTab = [
    const Tab(text: 'Belum dibuat'),
    const Tab(text: 'Selesai'),
  ];
  @override
  Widget build(BuildContext context) {
    // int index = ModalRoute.of(context).settings.arguments as int;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          // initialIndex: index??0,
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
              elevation: 0,
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
                Center(
                  child: Column(
                    children: [
                      BelumDibuat(),
                      BelumDibuat(),
                      BelumDibuat(),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      RiwayatCardPe(),
                      RiwayatCardPe(),
                      RiwayatCardPe(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
