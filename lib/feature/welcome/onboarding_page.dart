import 'package:e_menu_app/common/models/content_model.dart';
import 'package:e_menu_app/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/theme.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/home-page'),
                    text: "Let's Start",
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/auntentikasi'),
                    text: "Login",
                    backgroundColor: Colors.transparent,
                    borderColor: true,
                  ),
                ],
              ),
            ),
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
}
