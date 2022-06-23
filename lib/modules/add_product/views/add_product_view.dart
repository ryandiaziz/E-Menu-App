import 'package:e_menu_app/modules/add_product/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/theme.dart';
import '../../../widgets/custom_textfield.dart';

class AddProductView extends GetView<AddProductController> {
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
            controller.addProduct(
              controller.nameC.text,
              controller.priceC.text,
            );
          },
          child: Text(
            "Submit",
            style:
                secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                image: "assets/icon/icon_nama_menu.png",
                controller: controller.nameC,
                hintText: 'Nama Menu'),
            CustomTextField(
              image: "assets/icon/icon_price.png",
              controller: controller.priceC,
              hintText: "Harga",
            ),
            submitMenu()
          ],
        ),
      ),
    );
  }
}
