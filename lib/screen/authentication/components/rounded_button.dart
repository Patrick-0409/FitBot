import 'package:flutter/material.dart';

import '../../../constant.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  final double wid;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kLoginColor,
    this.textColor = Colors.white,
    required this.wid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: wid,
      height: size.height * 0.08,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8), child: newElevatedButton()),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          textStyle: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}
