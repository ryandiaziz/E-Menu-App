import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class TambahMejaPage extends StatefulWidget {
  const TambahMejaPage({Key? key}) : super(key: key);

  @override
  State<TambahMejaPage> createState() => _TambahMejaPageState();
}

class _TambahMejaPageState extends State<TambahMejaPage> {
  TextEditingController qrC = TextEditingController();
  Uint8List? bytes;
  String? noMeja;
  String? idMeja;
  String? restoId;

  void vaildation() async {
    if (qrC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: priceColor,
          content: const Text("Isi nomor meja!"),
        ),
      );
    } else {
      await createTable(restoId!);
    }
  }

  Future createTable(String idResto) async {
    final docMenu = FirebaseFirestore.instance.collection('tables').doc();
    setState(() {
      idMeja = docMenu.id;
    });

    await docMenu.set({
      'id': idMeja,
      'noMeja': noMeja,
      'idResto': idResto,
    });

    // Navigator.pushReplacementNamed(context, '/profile-ad');
    // Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Daftar Berhasil'),
      backgroundColor: priceColor,
    ));
  }

  Future<String> saveQRImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final name = '($idMeja)Meja Nomor $noMeja';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: priceColor,
        content: const Text("QR Code Berhasil disimpan"),
      ),
    );

    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    String idResto = ModalRoute.of(context)!.settings.arguments as String;
    Widget qrGenerate() {
      return Center(
        child: QrImage(
          data: idMeja ?? "E-Menu",
          size: 300,
        ),
      );
    }

    Widget nomejaInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xffEFF0F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.numbers_rounded,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: qrC,
                        style: primaryTextStyle,
                        decoration: InputDecoration(
                          hintText: "Masukan Nomor Meja",
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget submitMeja() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () async {
              setState(() {
                noMeja = qrC.text;
                restoId = idResto;
              });
              vaildation();
              // Navigator.pushNamed(context, '/scanning-page');
            },
            child: Text(
              "Submit",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

    Widget saveQR() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () async {
              final controller = ScreenshotController();
              final bytes = await controller
                  .captureFromWidget(Material(child: qrGenerate()));
              setState(() {
                this.bytes = bytes;
              });
              await saveQRImage(bytes);

              setState(() {
                idMeja = null;
              });
            },
            child: Text(
              "Save QR Code",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

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
        elevation: 1,
        title: Text(
          "Tambah Meja",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header(),

                nomejaInput(),
                idMeja == null ? submitMeja() : saveQR(),
                idMeja == null ? const SizedBox() : qrGenerate(),
                // bytes != null ? Image.memory(bytes!) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
