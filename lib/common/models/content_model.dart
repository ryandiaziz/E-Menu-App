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
    image: "assets/svg/easy-order.svg",
    discription: "Pesan dan bayar sendiri melalui smartphone",
  ),
  UnboardingContent(
    title: "Easy Order",
    image: "assets/svg/self-order.svg",
    discription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
  ),
  UnboardingContent(
    title: "Enjoy",
    image: "assets/svg/enjoy.svg",
    discription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et",
  ),
];
