import 'package:flutter/material.dart';

import '../../../../constant.dart';

class TimerButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;

  const TimerButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.30,
      height: size.height * 0.06,
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
          // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          textStyle: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}
