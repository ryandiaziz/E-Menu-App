import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../order/pages/order_page.dart';

class Maintenance extends StatelessWidget {
  const Maintenance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              // sabri GXlT5F05zPBT9a8hDJxB
              // aby hZNZbzGDkuLZ3dD95L4X
              // rhumbia  8V3z0yVONyrhd2hRT1xY
              MaterialPageRoute(
                builder: (_) => const NavigationPage(
                  idMeja: 'hZNZbzGDkuLZ3dD95L4X',
                ),
              ),
            );
          },
          child: const Icon(Icons.menu_book),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/onboarding-page");
          },
          child: const Icon(Icons.logout),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
