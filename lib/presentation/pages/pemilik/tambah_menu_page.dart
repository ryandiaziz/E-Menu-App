import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class TambahMenuPage extends StatefulWidget {
  const TambahMenuPage({Key? key}) : super(key: key);

  @override
  State<TambahMenuPage> createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  final TextEditingController _namaProdukC = TextEditingController();
  final TextEditingController _hargaProdukC = TextEditingController();
  final TextEditingController _jenisProdukC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaProdukC.dispose();
    _hargaProdukC.dispose();
    _jenisProdukC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget submitMenu() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 40),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              // Navigator.pushNamed(context, '/scanning-page');
            },
            child: Text(
              "Submit",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
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
          "Tambah Menu",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          children: [
            CustomTextField(
                image: "assets/icon/icon_profile_select.png",
                controller: _namaProdukC,
                hintText: 'Nama Menu'),
            CustomTextField(
              image: "assets/icon/icon_profile_select.png",
              controller: _hargaProdukC,
              hintText: "Harga",
            ),
            CustomTextField(
              image: "assets/icon/icon_profile_select.png",
              controller: _jenisProdukC,
              hintText: "Jenis Produk",
            ),
            submitMenu()
          ],
        ),
      ),
    );
  }
}
