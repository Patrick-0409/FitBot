import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonTimeBased extends StatelessWidget {
  const ButtonTimeBased({
    Key? key,
    required this.size,
    required this.press,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Size size;
  final Function() press;
  final Color color;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                width: size.width * 0.28,
                height: size.height * 0.11,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    text,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
