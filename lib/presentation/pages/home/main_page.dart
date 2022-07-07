import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/shared/theme.dart';

import '../../../widgets/drawer.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              // right: 24,
              top: 22,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/list-restoran');
                  },
                  child: Image.asset(
                    "assets/icon/icon_restoran.png",
                    width: 30,
                    color: secondsubtitleColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile-cus');
                  },
                  child: Image.asset(
                    'assets/icon/icon_profile_select.png',
                    width: 30,
                    color: secondsubtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget qrCodeAttribute() {
      return Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  // height: 300,
                  // width: double.infinity,
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: priceColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2,
                          // offset: const Offset(3, 3),
                        ),
                      ]),
                  child: Center(
                    child: Center(
                      child: Image.asset(
                        'assets/icon/icon_qrCode.png',
                        width: 200,
                        color: secondsubtitleColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
    }

    Widget scanButton() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              Navigator.pushNamed(context, '/scanning-page');
            },
            child: Text(
              "Scan QR Code",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

    Widget loginButton() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 20),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
            child: Text(
              "Login",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ",
                style: subtitleTextStyle.copyWith(fontSize: 12)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                "Sign Up",
                style:
                    priceTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrawer(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                qrCodeAttribute(),
                Center(
                  child: scanButton(),
                ),
                Center(
                  child: loginButton(),
                ),
                const Spacer(),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
