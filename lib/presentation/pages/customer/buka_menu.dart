import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/models/restaurant_model.dart';
import 'package:e_menu_app/presentation/pages/customer/profile_cus_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';

import '../../../aplication/auth/cubit/auth_cubit.dart';

class BukaMenuPage extends StatefulWidget {
  const BukaMenuPage({Key? key}) : super(key: key);

  @override
  State<BukaMenuPage> createState() => _BukaMenuPageState();
}

class _BukaMenuPageState extends State<BukaMenuPage> {
  TextEditingController namarestoranC = TextEditingController();
  TextEditingController alamatrestoranC = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;

  File? image;
  String? imageUrl;
  String iduser = '';
  bool resto = true;

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final imagePicked = await _picker.pickImage(source: source);
    final imageCrop = await ImageCropper().cropImage(
        sourcePath: '${imagePicked?.path}',
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (imageCrop == null) {
      return;
    }
    image = File(imageCrop.path);
    setState(() {});
  }

  Future<void> _upload(String pathh) async {
    try {
      // Uploading the selected image
      final ref =
          storage.ref().child('restaurantImages').child(path.basename(pathh));
      final result = await ref.putFile(File(pathh));
      final fileUrl = await result.ref.getDownloadURL();
      setState(() {
        imageUrl = fileUrl;
      });
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  void getUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      iduser = vari.data()!['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomSheetResto() {
      return Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            const Text("Pilih Foto"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop;
                        getImage(ImageSource.camera);
                        _upload('${image?.path}');
                      },
                      child: const Icon(Icons.camera),
                    ),
                    const Text('Kamera')
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await getImage(ImageSource.gallery);
                        _upload('${image?.path}');
                      },
                      child: const Icon(Icons.image),
                    ),
                    const Text('Galeri')
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    Widget fotoResto() {
      return Center(
        child: Stack(
          children: [
            imageUrl != null
                ? SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipOval(
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipOval(
                        child: Image.asset(
                      "assets/img/image_profile_user.png",
                      width: 64,
                    )),
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) => bottomSheetResto(),
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor3,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: secondsubtitleColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget namarestoran() {
      return Container(
        margin: const EdgeInsets.only(top: 40),
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
                    Image.asset(
                      'assets/icon/icon_profile_select.png',
                      width: 17,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: namarestoranC,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: "Nama Restoran",
                            hintStyle: subtitleTextStyle),
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

    Widget alamatrestoran() {
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
                    Image.asset(
                      'assets/icon/icon_profile_select.png',
                      width: 17,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: alamatrestoranC,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: "Alamat Restoran",
                            hintStyle: subtitleTextStyle),
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

    Widget header() {
      User? user = FirebaseAuth.instance.currentUser;
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
            final dataresto = Restaurant(
              name: namarestoranC.text,
              alamat: alamatrestoranC.text,
              imageUrl: '$imageUrl',
              idUser: user!.uid,
            );
            createRestaurant(dataresto);
          },
          child: Text(
            'Buka E-Menu',
            style:
                secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
        ),
      );
    }

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
            // getUID();
            // final dataresto = Restaurant(
            //   name: namarestoranC.text,
            //   alamat: alamatrestoranC.text,
            //   imageUrl: '$imageUrl',

            // );

            // createRestaurant(dataresto);
          },
          child: Text(
            'Buka E-Menu',
            style:
                secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
        ),
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
          elevation: 0,
          title: Text(
            "Buka E-Menu",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 130,
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Column(
              children: [
                fotoResto(),
                namarestoran(),
                alamatrestoran(),
                header(),
                // showdata(context),
              ],
            ),
          ),
        ));
  }

  Future createRestaurant(Restaurant dataresto) async {
    final docResto = FirebaseFirestore.instance.collection('restaurant').doc();
    dataresto.id = docResto.id;

    final json = dataresto.toJson();
    await docResto.set(json);

    Navigator.pushNamed(context, '/profile-ad', arguments: resto);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Daftar Berhasil'),
      backgroundColor: priceColor,
    ));
  }
}
