class UnboardingContent {
  String image;
  String title;
  String discription;

  UnboardingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<UnboardingContent> contents = [
  UnboardingContent(
    title: "Self Order",
    image: "assets/img/undraw_order_confirmed_re_g0if.svg",
    discription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  ),
  UnboardingContent(
    title: "Fast Order",
    image: "assets/img/undraw_eating_together_re_ux62.svg",
    discription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  ),
  UnboardingContent(
    title: "Easy Order",
    image: "assets/img/undraw_online_groceries_a02y.svg",
    discription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  ),
];
