import 'package:e_menu_app/presentation/pages/customer/buka_menu.dart';
import 'package:e_menu_app/presentation/pages/customer/riwayat_pesanan_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/meja_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/owner_menu_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/tambah_meja_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/tambah_menu_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_menu_app/presentation/pages/home/list_retoran_page.dart';
import 'package:e_menu_app/presentation/pages/product/detail_product_page.dart';
import 'package:e_menu_app/presentation/profile/edit_profile_resto.dart';
import 'package:e_menu_app/presentation/splash_page/splash_page.dart';
import 'common/widgets/qr_scanner.dart';

import 'feature/authentication/pages/autentifikasi.dart';
import 'feature/home/home_page.dart';
import 'feature/welcome/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding-page': (context) => const Onboarding(),
        '/qrscan': (context) => const QRScanPage(),
        '/home-page': (context) => const HomePage(),
        '/auntentikasi': (context) => const Autentikasi(),
        '/restaurant-page': (context) => const ListRestoran(),
        '/detail-product': (context) => const DetailProductPage(),
        '/edit-profile-resto': (context) => const EditProfileRestoPage(),
        '/menu-admin': (context) => const MenuPage(),
        '/tambah-menu-admin': (context) => const TambahMenuPage(),
        '/meja-admin': (context) => const MejaPage(),
        '/tambah-meja-admin': (context) => const TambahMejaPage(),
        '/riwayat-pesanan-anda': (context) => const RiwayatPesananPage(),
        '/buka-emenu': (context) => const BukaMenuPage(),
      },
      title: 'Flutter Demo',
      // theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      // primarySwatch: Colors.blue,
    );
    // );
  }
}
