import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CusAppBar extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;

  const CusAppBar({
    Key? key,
    this.title,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get PreferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$title'),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
