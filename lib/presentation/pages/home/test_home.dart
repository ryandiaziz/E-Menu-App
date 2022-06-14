import 'package:flutter/material.dart';
import 'package:e_menu_app/shared/theme.dart';
// import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> myItems = [
    {
      "svgImage": "assets/images/emojione-monotone_green-salad.svg",
      "nameMenu": "Appetizer",
      "countData": "149 Course"
    },
    {
      "svgImage": "assets/images/emojione-monotone_pot-of-food.svg",
      "nameMenu": "Main Dish",
      "countData": "50 Course"
    },
    {
      "svgImage": "assets/images/emojione-monotone_ice-cream.svg",
      "nameMenu": "Desserts",
      "countData": "225 Course"
    }
  ];

  final List<Map> myFoodPopular = [
    {
      "imagePopular": "assets/img/image_burger.png",
      "namePopular": "Nasi Goreng Telur",
      "ratingPopular": "4012"
    },
    {
      "imagePopular": "assets/img/image_burger2.png",
      "namePopular": "Daging Rendang Padang",
      "ratingPopular": "2009"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor1,
          //BAR NAVIGASI
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: const Color(0xff3267E3),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            elevation: 0,
            items: [
              const BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home_outlined),
              ),
              const BottomNavigationBarItem(
                label: "Pesanan",
                icon: Icon(Icons.paste_outlined),
              ),
              const BottomNavigationBarItem(
                label: "Pesan",
                icon: Icon(Icons.inbox_outlined),
              ),
              const BottomNavigationBarItem(
                label: "Sttings",
                icon: Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //KOLOM 1
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //BARIS 1
                  Row(
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/img/image_profile_user.png'),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xffD7E6FD),
                        radius: 30.0,
                        child: IconButton(
                          splashColor: Colors.white.withOpacity(0),
                          iconSize: 30.0,
                          onPressed: () {},
                          icon: Icon(Icons.search),
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xffD7E6FD),
                        radius: 30.0,
                        child: IconButton(
                          splashColor: Colors.white.withOpacity(0),
                          iconSize: 30.0,
                          onPressed: () {},
                          icon: Icon(Icons.notifications_none),
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  //BARIS 2
                  const SizedBox(height: 10),
                  const Text(
                    'Hallo, Tommy',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //BARIS 3
                  const Text(
                    'What food you want today?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: myItems
                          .map((item) => Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Color(0xffD7E6FD),
                                      radius: 20.0,
                                      // child: SvgPicture.asset(
                                      //   item['svgImage'],
                                      //   height: 25,
                                      //   width: 25,
                                      // ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Text(
                                      item['nameMenu'],
                                      style: TextStyle(
                                        color: Color(0xff082431),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item['countData'],
                                      style: TextStyle(
                                        color: Color(0xffA2ADB1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Food',
                        style: TextStyle(
                          color: Color(0xff082431),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Show all',
                        style: TextStyle(
                          color: Color(0xff006EEE),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: myFoodPopular
                          .map(
                            (popular) => SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: GridTile(
                                    child: Image.asset(
                                      popular['imagePopular'],
                                      fit: BoxFit.cover,
                                    ),
                                    footer: SizedBox(
                                      height: 70,
                                      child: GridTileBar(
                                        backgroundColor: Colors.white,
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                popular['namePopular'],
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff082431),
                                                ),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Favorite',
                        style: TextStyle(
                          color: Color(0xff082431),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Show all',
                        style: TextStyle(
                          color: Color(0xff006EEE),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: myFoodPopular
                          .map(
                            (popular) => SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: GridTile(
                                    child: Image.asset(
                                      popular['imagePopular'],
                                      fit: BoxFit.cover,
                                    ),
                                    footer: SizedBox(
                                      height: 70,
                                      child: GridTileBar(
                                        backgroundColor: Colors.white,
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                popular['namePopular'],
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff082431),
                                                ),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                  Icon(
                                                    Icons.star_outlined,
                                                    color: Color(0xffFFBC58),
                                                    size: 18,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
