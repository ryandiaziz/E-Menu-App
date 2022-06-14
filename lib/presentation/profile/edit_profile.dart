import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    // image: NetworkImage(user.profilePhotoUrl),
                    image: AssetImage("assets/img/image_profile_user.png")),
              ),
            ),
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
}
