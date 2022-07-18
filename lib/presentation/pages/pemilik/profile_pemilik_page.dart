import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../aplication/auth/cubit/auth_cubit.dart';

class ProfileAdPage extends StatelessWidget {
  const ProfileAdPage({Key? key}) : super(key: key);

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
                content: Text("Berhasil Keluar"),
                backgroundColor: primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: SafeArea(
                  child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: priceColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/img/image_profile_user.png",
                            width: 64,
                          ),
                        ),
                        Text(
                          state.user.displayName,
                          style: titleTextStyle.copyWith(
                              fontSize: 24, fontWeight: semiBold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              )),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    Widget menuItem(text) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
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

    Widget menuItemPesanan(_gambar, text) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              _gambar,
              width: 24,
            ),
            Text(
              text,
              style: titleTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget pesanan() {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(CupertinoIcons.square_list),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pesanan",
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: AppColor.placeholder.withOpacity(0.25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/pesanan-page-admin');
                      },
                      child: menuItemPesanan(
                          "assets/icon/icon_belumdibuat.png", "Belum Dibuat"),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/pesanan-page-admin');
                      },
                      child: menuItemPesanan(
                          "assets/icon/icon_selesai.png", "Selesai"),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: menuItemPesanan(
                          "assets/icon/icon_riwayat.png", "Riwayat Pesanan"),
                    )
                  ],
                ),
              ],
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
          margin: const EdgeInsets.only(bottom: 10),
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
                    Navigator.pushNamed(context, '/menu-admin');
                  },
                  child: menuItem("Menu Saya")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/tambah-menu-admin');
                  },
                  child: menuItem("Tambah Menu")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/meja-admin');
                  },
                  child: menuItem("Meja Saya")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/tambah-meja-admin');
                  },
                  child: menuItem("Tambah Meja")),
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
            pesanan(),
            content(),
          ],
        ));
  }
}
