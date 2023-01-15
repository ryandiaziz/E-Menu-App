import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/pemilik/pesanan_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/saldo_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KelolaRestoPage extends StatefulWidget {
  final String idResto;

  const KelolaRestoPage(this.idResto, {Key? key}) : super(key: key);

  @override
  State<KelolaRestoPage> createState() => _KelolaRestoPageState(idResto);
}

class _KelolaRestoPageState extends State<KelolaRestoPage> {
  final String _idResto;
  _KelolaRestoPageState(this._idResto);
  @override
  Widget build(BuildContext context) {
    Widget header(data) {
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: priceColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      data['imageUrl'],
                      width: 64,
                    ),
                  ),
                  Text(
                    data['name'],
                    style: titleTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        )),
      );
    }

    Widget menuItem(text) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: titleTextStyle.copyWith(fontWeight: medium),
            ),
            Icon(
              Icons.chevron_right,
              color: secondsubtitleColor,
            )
          ],
        ),
      );
    }

    Widget menuItemPesanan(_gambar, text) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              _gambar,
              width: 24,
              color: secondsubtitleColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: titleTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget pesanan(data) {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.square_list,
                  color: secondsubtitleColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pesanan",
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        int index = 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PesananPage(index: index, idResto: _idResto),
                          ),
                        );
                        // Navigator.pushNamed(context, '/pesanan-page-admin',
                        //     arguments: idResto);
                      },
                      child: menuItemPesanan(
                        "assets/icon/menu-belum-dibuat.png",
                        "Belum Dibuat",
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        int index = 1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PesananPage(
                              index: index,
                              idResto: _idResto,
                            ),
                          ),
                        );
                        // Navigator.pushNamed(context, '/pesanan-page-admin',
                        //     arguments: idResto);
                      },
                      child: menuItemPesanan(
                        "assets/icon/menu-selesai.png",
                        "Selesai",
                      ),
                    )
                  ],
                ),
                // Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: menuItemPesanan(
                //           "assets/icon/menu-riwayat.png", "Riwayat Pesanan"),
                //     )
                //   ],
                // ),
              ],
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          // color: Colors.yellow,
          padding: const EdgeInsets.only(left: 10, right: 10),
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/edit-profile-resto',
                    arguments: _idResto,
                  );
                },
                child: menuItem("Data Restoran"),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   '/saldo-page',
                  //   arguments: _idResto,
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SaldoPage(
                        idResto: _idResto,
                      ),
                    ),
                  );
                },
                child: menuItem("Saldo"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/menu-admin',
                    arguments: _idResto,
                  );
                },
                child: menuItem("Menu Saya"),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/tambah-menu-admin',
                      arguments: _idResto,
                    );
                  },
                  child: menuItem("Tambah Menu")),
              // GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/meja-admin');
              //     },
              //     child: menuItem("Meja Saya")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/tambah-meja-admin',
                      arguments: _idResto,
                    );
                  },
                  child: menuItem(
                    "Tambah Meja",
                  )),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.placeholderBg,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("restaurants")
            .doc(_idResto)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              header(data),
              pesanan(data),
              content(),
            ],
          );
        },
      ),
    );
  }
}
// child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
//           builder: (BuildContext context, AsyncSnapshot snapshot){
//             var data = snapshot.data;
//             if(data==null){
//               return Center(child: CircularProgressIndicator(),);
//             }
//             return setDataToTextField(data);
//           },

//         ),
//       )),
