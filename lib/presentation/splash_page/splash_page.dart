import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/shared/theme.dart';

import '../../aplication/auth/cubit/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home-page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icon/icon_emenu.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
