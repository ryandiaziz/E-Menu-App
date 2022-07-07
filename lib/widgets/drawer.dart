import 'package:e_menu_app/presentation/pages/home/onboarding_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: backgroundColor3,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Onboarding()));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 52,
                  backgroundImage:
                      AssetImage('assets/img/image_profile_user.png'),
                ),
                const SizedBox(height: 12),
                Text(
                  "Nama",
                  style: titleTextStyle.copyWith(fontSize: 28),
                ),
                Text(
                  "nama@gmail.com",
                  style: titleTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Data Pribadi"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Riwayat Pesanan"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Buka E-Menu"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Keluar"),
              onTap: () {},
            )
          ],
        ),
      );
}
