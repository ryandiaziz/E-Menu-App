import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/home/data.dart';
import 'package:e_menu_app/feature/emenu/pages/kelola_resto_page.dart';
import 'package:e_menu_app/feature/profile/pages/edit_profile_user.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  var firestoreInstance = FirebaseFirestore.instance;

  List dataResto = [];

  String? idResto;

  fetchRestaurant() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    QuerySnapshot qn = await firestoreInstance
        .collection("restaurants")
        .where('idUser', isEqualTo: currentUser!.uid)
        .get();
    setState(() {
      dataResto.add({
        "id": qn.docs[0]["id"],
        "idUser": qn.docs[0]["idUser"],
        "name": qn.docs[0]["name"],
        "alamat": qn.docs[0]["alamat"],
        "imageUrl": qn.docs[0]["imageUrl"],
      });
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null
        ? Drawer(
            backgroundColor: Colors.white,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var dataUser = snapshot.data;
                if (dataUser == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildHeader(context, dataUser),
                    buildMenuItems(context, dataUser),
                  ],
                ));
              },
            ),
          )
        : Drawer(
            backgroundColor: Colors.white,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 370),
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/auntentikasi');
                },
                child: const Text('Login'),
              ),
            ),
          );
  }

  Widget buildHeader(BuildContext context, dataUser) {
    return Material(
      // color: priceColor,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfileUserPage(dataUser: dataUser),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: AppColor.placeholder.withOpacity(0.25),
              ),
            ),
          ),
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              dataUser['imageUrl'] != null
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        dataUser['imageUrl'],
                      ),
                    )
                  : const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        "assets/img/image_profile_user.png",
                      ),
                    ),
              const SizedBox(height: 12),
              Text(
                dataUser["name"],
                style:
                    primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                dataUser["email"],
                style: secondPrimaryTextStyle.copyWith(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, dataUser) => Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 5,
          children: [
            dataUser["isAdmin"] == true
                ? ListTile(
                    leading: Image.asset(
                      'assets/icon/history.png',
                      width: 22,
                      color: secondsubtitleColor,
                    ),
                    title: Text(
                      "Users & Restaurants Data",
                      style: secondPrimaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DataPage(),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
            ListTile(
              leading: Image.asset(
                'assets/icon/history.png',
                width: 22,
                color: secondsubtitleColor,
              ),
              title: Text(
                "Riwayat Pesanan",
                style: secondPrimaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: medium),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/riwayat-pesanan-anda');
              },
            ),
            dataUser["isOwner"] == true
                ? ListTile(
                    leading: Image.asset(
                      'assets/icon/menu.png',
                      width: 25,
                      color: secondsubtitleColor,
                    ),
                    title: Text(
                      "E-Menu",
                      style: secondPrimaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    onTap: () {
                      setState(() {
                        idResto = dataUser['idResto'];
                      });
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KelolaRestoPage(idResto!),
                        ),
                      );
                    },
                  )
                : ListTile(
                    leading: Image.asset(
                      'assets/icon/menu.png',
                      width: 25,
                      color: secondsubtitleColor,
                    ),
                    title: Text(
                      'Buka E-Menu',
                      style: secondPrimaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/buka-emenu');
                    },
                  ),
            ListTile(
              leading: Image.asset(
                'assets/icon/log-out.png',
                width: 23,
                color: secondsubtitleColor,
              ),
              title: Text(
                "Keluar",
                style: secondPrimaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: medium),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(
                  context,
                  "/onboarding-page",
                );
              },
            ),
          ],
        ),
      );
}
