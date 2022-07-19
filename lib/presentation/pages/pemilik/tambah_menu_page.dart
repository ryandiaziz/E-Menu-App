import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../models/menu_model.dart';

class TambahMenuPage extends StatefulWidget {
  const TambahMenuPage({Key? key}) : super(key: key);

  @override
  State<TambahMenuPage> createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  final TextEditingController _namaProdukC = TextEditingController();
  final TextEditingController _hargaProdukC = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> items = ['Makanan', 'Minuman', 'Cemilan'];
  String selectedItem = 'Makanan';

  File? image;
  String? imageUrl;
  String? iduser;

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
      final ref = storage.ref().child('menuImages').child(path.basename(pathh));
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

  // void getUID() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var vari = await FirebaseFirestore.instance
  //       .collection('restaurant')
  //       .where('idUser',isEqualTo: user!.uid )
  //       .get();
  //   setState(() {
  //     iduser = vari.docs.forEach((element) { });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _namaProdukC.dispose();
    _hargaProdukC.dispose();
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
                        // await _upload('${image?.path}');
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

    Widget menuImage() {
      return Center(
        child: Stack(
          children: [
            image != null
                ? SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "assets/img/img_restoran.jpg",
                      fit: BoxFit.cover,
                    ),
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

    Widget buildCategory() {
      return Container(
        color: const Color(0xffEFF0F6),
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 50,
        child: DropdownButtonFormField<String>(
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem(
                    child: Text(
                      item,
                      style: primaryTextStyle,
                    ),
                    value: item,
                  ))
              .toList(),
          onChanged: (item) => setState(() {
            selectedItem = item!;
          }),
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
            onPressed: () async {
              await _upload('${image?.path}');
              final datamenu = Menu(
                nama: _namaProdukC.text,
                harga: _hargaProdukC.text,
                kategori: selectedItem,
                imageUrl: '$imageUrl',
              );
              createMenu(datamenu);
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
              menuImage(),
              CustomTextField(
                  image: "assets/icon/icon_nama_menu.png",
                  controller: _namaProdukC,
                  hintText: 'Nama Menu'),
              CustomTextField(
                image: "assets/icon/icon_price.png",
                controller: _hargaProdukC,
                hintText: "Harga",
              ),
              buildCategory(),
              submitMenu()
            ],
          ),
        ),
      ),
    );
  }

  Future createMenu(Menu datamenu) async {
    final docMenu = FirebaseFirestore.instance
        .collection('restaurant')
        .doc('Fv9wbK0CFM3GFeWphXzh')
        .collection('menu')
        .doc();
    datamenu.id = docMenu.id;

    final json = datamenu.toJson();
    await docMenu.set(json);

    Navigator.pushNamed(
      context,
      '/profile-ad',
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Daftar Berhasil'),
      backgroundColor: priceColor,
    ));
  }
}
