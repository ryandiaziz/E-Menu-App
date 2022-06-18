import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // File? image;

  @override
  Widget build(BuildContext context) {
    Widget modalsheet() {
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
                        await getImage(ImageSource.camera);
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
                    builder: (builder) => modalsheet(),
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

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Nama",
            style: primaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
                // hintText: "${user.name}",
                hintText: "Yo",
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor))),
          )
        ]),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Username",
            style: primaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
                // hintText: "${user.username}",
                hintText: "@yo",
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor))),
          )
        ]),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Email Address",
            style: primaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
                // hintText: "${user.email}",
                hintText: "yo@gmail.com",
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor))),
          )
        ]),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fotoProfile(),
            nameInput(),
            usernameInput(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: primaryColor,
              )),
          title: Text(
            "Edit Profile",
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          actions: const [
            Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        ),
        body: content(),
        resizeToAvoidBottomInset: false);
  }

  File? image;

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: source);
    image = File(imagePicked!.path);
    setState(() {
      // this.image;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }
}
