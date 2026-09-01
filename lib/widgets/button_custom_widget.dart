import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  String? title;
  bool? loading;
  VoidCallback? onClick;
  ButtonCustomWidget({super.key, this.title, this.onClick, this.loading=false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Center(
          child: loading == false ?
          Text(title ?? "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
          : CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
