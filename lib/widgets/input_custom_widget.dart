import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputCustomWidget extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  InputCustomWidget({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 2, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
