import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CusAPp extends StatefulWidget {
  const CusAPp({Key? key}) : super(key: key);

  @override
  State<CusAPp> createState() => _CusAPpState();
}

class _CusAPpState extends State<CusAPp> {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: secondsubtitleColor,
        ),
        onPressed: () {},
      ),
      title: Text(
        "Tambah Menu",
        style: primaryTextStyle.copyWith(fontWeight: semiBold),
        // fontWeight: semiBold,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.percent),
          onPressed: () {},
        ),
      ],
    );
  }
}
