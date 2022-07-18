import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TambahMejaPage extends StatefulWidget {
  const TambahMejaPage({Key? key}) : super(key: key);

  @override
  State<TambahMejaPage> createState() => _TambahMejaPageState();
}

class _TambahMejaPageState extends State<TambahMejaPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget qrGenerate() {
      return Center(
        child: QrImage(
          data: controller.text,
          size: 300,
        ),
      );
    }

    Widget nomejaInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xffEFF0F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.numbers_rounded,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        style: primaryTextStyle,
                        decoration: InputDecoration(
                            hintText: "Masukan Nomor Meja",
                            hintStyle: subtitleTextStyle,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: Icon(Icons.done),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget submitMeja() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 40),
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: priceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              // Navigator.pushNamed(context, '/scanning-page');
            },
            child: Text(
              "Submit",
              style: secondaryTextStyle.copyWith(
                  fontSize: 18, fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: secondsubtitleColor,
            ),
          ),
          automaticallyImplyLeading: true,
          titleSpacing: -5,
          elevation: 0,
          title: Text(
            "Tambah Meja",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header(),
                  qrGenerate(),
                  nomejaInput(),
                  submitMeja(),
                ],
              ),
            ),
          ),
        ));
  }
}
