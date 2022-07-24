// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/models/restaurant_model.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ));
        } else if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboarding-page', (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Berhasil Keluar"),
              backgroundColor: priceColor,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccess) {
          return Material(
            color: priceColor,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/editProfile');
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top,
                  bottom: 24,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage("assets/img/image_profile_user.png"),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.user.displayName,
                      style: primaryTextStyle.copyWith(
                          fontSize: 24, fontWeight: bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.user.email,
                      style: secondPrimaryTextStyle.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  List<String> docID = [];

  Future getDocId() async {
    User? user = FirebaseAuth.instance.currentUser;
    final doc = FirebaseFirestore.instance
        .collection('restaurant')
        .where('idUser', isEqualTo: user!.uid);
  }
}

bool? dta;

Widget buildMenuItems(BuildContext context) => Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 5,
        children: [
          ListTile(
            leading: Image.asset(
              'assets/icon/history.png',
              width: 25,
              color: secondsubtitleColor,
            ),
            title: Text(
              "Riwayat Pesanan",
              style: secondPrimaryTextStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/riwayat-pesanan-anda');
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icon/menu.png',
              width: 25,
              color: secondsubtitleColor,
            ),
            title: Text(
              "E-Menu",
              style: secondPrimaryTextStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile-ad');
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icon/menu.png',
              width: 25,
              color: secondsubtitleColor,
            ),
            title: Text(
              'Buka E-Menu',
              style: secondPrimaryTextStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/buka-emenu');
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icon/log-out.png',
              width: 25,
              color: secondsubtitleColor,
            ),
            title: Text(
              "Keluar",
              style: secondPrimaryTextStyle.copyWith(fontSize: 14),
            ),
            onTap: () {
              context.read<AuthCubit>().signOut();
            },
          ),
        ],
      ),
    );
