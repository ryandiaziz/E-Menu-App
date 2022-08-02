import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class EditProfileUserPage extends StatefulWidget {
  const EditProfileUserPage({Key? key}) : super(key: key);

  @override
  State<EditProfileUserPage> createState() => _EditProfileUserPageState();
}

class _EditProfileUserPageState extends State<EditProfileUserPage> {
  // File? image;

  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController? namaC;
  TextEditingController? emailC;
  File? image;
  String? imageUrl;

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

    Widget fotoProfile(dataUser) {
      return Center(
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
                : dataUser['imageUrl'] != null
                    ? SizedBox(
                        height: 120,
                        width: 120,
                        child: ClipOval(
                          child: Image.network(
                            dataUser['imageUrl'],
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

    Widget nama(dataUser) {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Nama",
            style: primaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            controller: namaC = TextEditingController(text: dataUser['name']),
            decoration: InputDecoration(

                // hintText: "${user.name}",
                hintText: dataUser['name'],
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor))),
          )
        ]),
      );
    }

    Widget email(dataUser) {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Email",
            style: primaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            readOnly: true,
            style: primaryTextStyle,
            controller: emailC = TextEditingController(text: dataUser['email']),
            decoration: InputDecoration(
                // hintText: "${user.username}",
                hintText: dataUser['email'],
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor))),
          )
        ]),
      );
    }

    Widget submit(dataUser) {
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

            var upadateResto = FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.email);

            upadateResto.update({
              'name': namaC!.text,
              'alamat': emailC!.text,
              'imageUrl': imageUrl ?? dataUser['imageUrl'],
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

    Widget content(dataUser) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fotoProfile(dataUser),
            nama(dataUser),
            email(dataUser),
            submit(dataUser),
          ],
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
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
          // fontWeight: semiBold,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var dataUser = snapshot.data;
          if (dataUser == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              content(dataUser),
            ],
          ));
        },
      ),
    );
  }
}
