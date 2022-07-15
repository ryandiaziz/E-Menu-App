import 'package:e_menu_app/presentation/pages/customer/buka_menu.dart';
import 'package:e_menu_app/presentation/pages/customer/profile_cus_page.dart';
import 'package:e_menu_app/presentation/pages/customer/riwayat_pesanan_page.dart';
import 'package:e_menu_app/presentation/pages/home/detail_restoran_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/meja_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/menu_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/pesanan_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/tambah_meja_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/tambah_menu_page.dart';
import 'package:e_menu_app/presentation/pages/pemilik/profile_pemilik_page.dart';
import 'package:e_menu_app/widgets/qr_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/presentation/pages/home/list_retoran_page.dart';
import 'package:e_menu_app/presentation/pages/product/detail_product_page.dart';
import 'package:e_menu_app/presentation/profile/edit_profile.dart';
import 'package:e_menu_app/presentation/sign_in/sign_in_page.dart';
import 'package:e_menu_app/presentation/sign_up/sign_up_page.dart';
import 'package:e_menu_app/presentation/splash_page/splash_page.dart';

import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/home/navigation.dart';
import 'presentation/pages/home/onboarding_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          // '/': (context) => const ScanPage(),
          '/': (context) => const SplashPage(),
          '/onboarding-page': (context) => const Onboarding(),
          '/home-page': (context) => const HomePage(),
          '/scan-page': (context) => QRScanPage(),
          '/restaurant-page': (context) => ListRestoran(),
          '/navigation-page': (context) => const NavigationPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/detail-product': (context) => const DetailProductPage(),
          '/profile-cus': (context) => const ProfileCusPage(),
          '/profile-ad': (context) => const ProfileAdPage(),
          '/editProfile': (context) => EditProfilePage(),
          '/pesanan-page-admin': (context) => const PesananPage(),
          '/menu-admin': (context) => const MenuPage(),
          '/tambah-menu-admin': (context) => const TambahMenuPage(),
          '/meja-admin': (context) => const MejaPage(),
          '/tambah-meja-admin': (context) => const TambahMejaPage(),
          '/riwayat-pesanan-anda': (context) => const RiwayatPesananPage(),
          '/buka-emenu': (context) => const BukaMenuPage(),
          '/detail-restoran': (context) => DetailRestoran(),
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
      ),
      // home: const SplashPage(),
      // getPages: AppRoute.pages,
    );
    // );
  }
}
