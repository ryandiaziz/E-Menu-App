import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String name, String price) async {
    CollectionReference products = firestore.collection('products');

    try {
      await products.add(
        {
          'name': name,
          'price': price,
        },
      );
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: 'Tidak berhasil menambahkan produk',
        onConfirm: () => Get.back(),
        textConfirm: 'OKE',
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: 'Tidak berhasil menambahkan produk',
      );
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }
}
