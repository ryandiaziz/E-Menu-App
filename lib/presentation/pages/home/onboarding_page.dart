import 'package:e_menu_app/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/content_model.dart';
import '../../../shared/theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 100 + MediaQuery.of(context).padding.top,
                      left: 20 + MediaQuery.of(context).padding.left,
                      right: 20 + MediaQuery.of(context).padding.right,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          contents[i].image,
                          height: 230,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          contents[i].title,
                          style: titleTextStyle.copyWith(
                              fontSize: 28, fontWeight: bold),
                        ),
                        Text(
                          contents[i].discription,
                          style: secondPrimaryTextStyle,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    contents.length, (index) => buildDot(index, context)),
              ),
            ),
            CustomElevatedButton(onPressed: () {}, text: "text"),
            letsStart(),
            toAutentifikasi(),
          ],
        ),
      );

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 7,
      width: currentIndex == index ? 25 : 7,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: priceColor,
      ),
    );
  }

  Widget letsStart() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: priceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home-page');
          },
          child: Text(
            "Let's Start",
            style: secondaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
          )),
    );
  }

  Widget toAutentifikasi() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 3.0, color: priceColor)),
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 40 + MediaQuery.of(context).padding.bottom),
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
          onPressed: () {
            Navigator.pushNamed(context, '/auntentikasi');
          },
          child: Text(
            "Login",
            style: secondaryTextStyle.copyWith(
                fontSize: 18, fontWeight: bold, color: priceColor),
          )),
    );
  }
}
