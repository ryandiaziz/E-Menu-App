import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class EditMenu extends StatefulWidget {
  final dynamic dataMenu;
  const EditMenu({this.dataMenu, Key? key}) : super(key: key);

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  // File? image;

  FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController? namaMenuC;
  TextEditingController? hargaMenuC;
  File? image;
  String? imageUrl;

  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = ['Makanan', 'Minuman', 'Cemilan'];

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

  @override
  void initState() {
    dropdownvalue = widget.dataMenu['kategori'];
    super.initState();
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

    Widget fotoProfile() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Stack(
            children: [
              image != null
                  ? SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipOval(
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : widget.dataMenu['imageUrl'] != null
                      ? SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipOval(
                            child: Image.network(
                              widget.dataMenu['imageUrl'],
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
        ),
      );
    }

    Widget buildCategory() {
      return Container(
        color: const Color(0xffEFF0F6),
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 50,
        child: DropdownButton(
          // Initial Value
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

        // child: DropdownButtonFormField<String>(
        //   value: selectedItem,
        //   items: items
        //       .map((item) => DropdownMenuItem(
        //             child: Text(
        //               item,
        //               style: primaryTextStyle,
        //             ),
        //             value: item,
        //           ))
        //       .toList(),
        //   onChanged: (item) => setState(() {
        //     selectedItem = item!;
        //   }),
        // ),
      );
    }

    // Widget buildgender() {
    //   return Container(
    //     color: const Color(0xffEFF0F6),
    //     margin: const EdgeInsets.only(top: 20),
    //     padding: const EdgeInsets.symmetric(horizontal: 15),
    //     width: double.infinity,
    //     height: 50,
    //     child: DropdownButton(
    //       // Initial Value
    //       value: dropdownvalue,
    //       hint: const Text('Pilih Jenis Kelamin'),

    //       // Down Arrow Icon
    //       icon: const Icon(Icons.keyboard_arrow_down),
    //       isExpanded: true,
    //       itemHeight: 50,

    //       // Array list of items
    //       items: items.map((String items) {
    //         return DropdownMenuItem(
    //           value: items,
    //           child: Text(items),
    //         );
    //       }).toList(),
    //       // After selecting the desired option,it will
    //       // change button value to selected value
    //       onChanged: (String? newValue) {
    //         setState(() {
    //           dropdownvalue = newValue!;
    //         });
    //       },
    //     ),

    //   );
    // }

    Widget submit() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 40),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: priceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          onPressed: () async {
            if (image != null) {
              await _upload('${image?.path}');
            }

            var upadateMenu = FirebaseFirestore.instance
                .collection('restaurants')
                .doc(widget.dataMenu['idResto'])
                .collection('menu')
                .doc(widget.dataMenu['id']);

            upadateMenu.update({
              'nama': namaMenuC!.text,
              'harga': int.parse(hargaMenuC!.text),
              'kategori': dropdownvalue,
              'imageUrl': imageUrl ?? widget.dataMenu['imageUrl'],
            });

            Navigator.pop(context);
          },
          child: Text(
            'Simpan',
            style:
                secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
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
          "Edit Menu",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              fotoProfile(),
              CustomTextField(
                image: 'assets/icon/icon_nama_menu.png',
                controller: namaMenuC =
                    TextEditingController(text: widget.dataMenu['nama']),
                hintText: 'Nama Menu',
                keyBoardType: TextInputType.text,
                read: false,
              ),
              CustomTextField(
                image: "assets/icon/icon_price.png",
                controller: hargaMenuC =
                    TextEditingController(text: '${widget.dataMenu['harga']}'),
                hintText: 'Input Email',
                keyBoardType: TextInputType.number,
                read: false,
              ),
              buildCategory(),
              submit(),
            ],
          ),
        ),
      ),
    );
  }
}
