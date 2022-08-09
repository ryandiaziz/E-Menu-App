import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/card/order_cus_cart.dart';
import 'package:e_menu_app/presentation/pages/customer/rincian_pesanan.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String dropdownvalue = 'users';

  // List of items in our dropdown menu
  var items = ['users', 'restaurants'];
  @override
  Widget build(BuildContext context) {
    Widget emptyOrder() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/undraw_no_data_re_kwbl.svg",
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Belum ada pesanan",
              style:
                  subtitleTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget pilihData() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: dropdownvalue,
          hint: const Text('Kategori'),

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          itemHeight: 50,

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      );
    }

    Widget buildData(dynamic data, int countData) {
      return Expanded(
        child: ListView.builder(
            itemCount: countData,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: data[index]['imageUrl'] != null
                        ? NetworkImage(data[index]['imageUrl'])
                        : const NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/e-menu-63b92.appspot.com/o/user.png?alt=media&token=dc8980d3-6e7a-4f03-b09a-fe1737364706'),
                  ),
                  title: Text(data[index]['name']),
                  dense: true,
                  subtitle: Text(data[index]['id']),
                ),
              );
            }),
      );
    }

    Widget getData() {
      return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(dropdownvalue).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: priceColor,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return emptyOrder();
          }
          dynamic data = snapshot.data?.docs;
          int? countData = snapshot.data?.docs.length;
          return buildData(data, countData!);
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
        automaticallyImplyLeading: true,
        titleSpacing: -5,
        elevation: 1,
        title: Text(
          "Data Users & Restaurants",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: Column(
        children: [
          pilihData(),
          getData(),
        ],
      ),
    );
  }
}
