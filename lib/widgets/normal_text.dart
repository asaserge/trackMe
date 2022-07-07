import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NormalText extends StatelessWidget {
   NormalText({
     Key? key,
     required this.text,
     this.color,
     this. size
  }) : super(key: key);

  String text;
  Color? color;
  double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Oswald',
        color: color,
        fontSize: size ?? 14.0
      ),
    );
  }
}
