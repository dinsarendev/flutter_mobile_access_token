import 'package:flutter/material.dart';

class AppbarCustomWidget extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  String? title;
  Color? backgroundColor;
  AppbarCustomWidget({
    super.key,
    this.actions,
    this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.cyan,
      title: Text(title ?? "", style: TextStyle(color: Colors.white)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
