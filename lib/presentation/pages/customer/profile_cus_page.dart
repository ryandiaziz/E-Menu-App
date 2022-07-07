import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../aplication/auth/cubit/auth_cubit.dart';

class ProfileCusPage extends StatefulWidget {
  const ProfileCusPage({Key? key}) : super(key: key);

  @override
  State<ProfileCusPage> createState() => _ProfileCusPageState();
}

class _ProfileCusPageState extends State<ProfileCusPage> {
  String? idUser;
  @override
  Widget build(BuildContext context) {
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user = authProvider.user;
    Widget header() {
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
                context, '/scan-page', (route) => false);
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
            String iduser = state.user.id;
            return AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    // right: 10,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                          child: Image.asset(
                        "assets/img/image_profile_user.png",
                        width: 64,
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.fullname,
                              style: titleTextStyle.copyWith(
                                  fontSize: 20, fontWeight: bold),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile-ad');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: priceColor, width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            color: priceColor,
                          ),
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                            bottom: 5,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text('Menu Saya',
                                  style: secondaryTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
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

    Widget menuItem(text) {
      return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
          ),
        ),
        // margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: titleTextStyle.copyWith(fontWeight: medium),
            ),
            Icon(
              Icons.chevron_right,
              color: secondsubtitleColor,
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          // color: Colors.yellow,
          padding: const EdgeInsets.only(left: 10, right: 10),
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/editProfile');
                },
                child: menuItem("Data Pribadi"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/riwayat-pesanan-anda');
                },
                child: menuItem("Riwayat Pesanan"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/buka-emenu');
                },
                child: menuItem("Buka E-Menu"),
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthCubit>().signOut();
                },
                child: menuItem("Keluar"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: AppColor.placeholderBg,
        body: Column(
          children: [
            header(),
            content(),
          ],
        ));
  }
}
