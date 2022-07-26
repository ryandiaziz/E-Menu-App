import 'package:e_menu_app/presentation/card/belum_dibuat_card.dart';
import 'package:e_menu_app/presentation/card/riwayat_pemilik_card.dart';
import 'package:e_menu_app/presentation/pages/home/home_page.dart';
import 'package:e_menu_app/presentation/pages/home/user_form.dart';
import 'package:e_menu_app/presentation/sign_in/sign_in_page.dart';
import 'package:e_menu_app/presentation/sign_up/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/change_screen.dart';
import '../../../widgets/custom_textfield.dart';

class Autentikasi extends StatefulWidget {
  const Autentikasi({Key? key}) : super(key: key);

  @override
  State<Autentikasi> createState() => _AutentikasiState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = RegExp(p);

class _AutentikasiState extends State<Autentikasi> {
  List<Tab> myTab = [
    const Tab(text: 'Sign In'),
    const Tab(text: 'Sign Up'),
  ];

  TextEditingController sI_emaiC = TextEditingController();
  TextEditingController sI_PasswordC = TextEditingController();
  TextEditingController sU_emaiC = TextEditingController();
  TextEditingController sU_PasswordC = TextEditingController();
  // bool isLoading = false;

  bool _isHiddenPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: sU_emaiC.text, password: sU_PasswordC.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => UserForm()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: sI_emaiC.text, password: sI_PasswordC.text);
      var authCredential = userCredential.user;
      (authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home-page');
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Center(
        child: Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icon/icon_emenu.png',
                  width: 250,
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            )),
      );
    }

    Widget passwordInput(TextEditingController controller) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xffEFF0F6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/icon_password.png',
                      width: 17,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        style: primaryTextStyle,
                        obscureText: _isHiddenPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHiddenPassword
                                  ? secondsubtitleColor
                                  : Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          // isCollapsed: true,
                          hintText: "Password",
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

    Widget _button(String buttonText, onPressed) {
      return Container(
          margin: const EdgeInsets.only(top: 40),
          height: 50,
          width: double.infinity,
          child: TextButton(
              // onPressed: hendleSignIn,
              onPressed: onPressed,
              style: TextButton.styleFrom(
                  backgroundColor: priceColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Text(
                buttonText,
                style: secondaryTextStyle.copyWith(
                    fontSize: 18, fontWeight: semiBold),
              )));
    }

    return DefaultTabController(
      length: myTab.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            header(),
            TabBar(
              labelColor: priceColor,
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 2,
              indicatorColor: priceColor,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle:
                  primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
              tabs: myTab,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: TabBarView(children: [
                  Column(
                    children: [
                      CustomTextField(
                        image: 'assets/icon/icon_email.png',
                        controller: sI_emaiC,
                        hintText: 'Email',
                      ),
                      passwordInput(sI_PasswordC),
                      _button('Sign In', () {
                        signIn();
                      })
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        image: 'assets/icon/icon_email.png',
                        controller: sU_emaiC,
                        hintText: 'Email',
                      ),
                      passwordInput(sU_PasswordC),
                      _button('Continue', () {
                        signUp();
                      })
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}