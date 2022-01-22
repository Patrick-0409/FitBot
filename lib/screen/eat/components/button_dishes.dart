import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonDishes extends StatelessWidget {
  const ButtonDishes({
    Key? key,
    required this.size,
    required this.press,
    required this.color,
    required this.text,
    required this.picture,
  }) : super(key: key);

  final Size size;
  final Function() press;
  final Color color;
  final Text text;
  final SvgPicture picture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: size.width * 0.21,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.only(top: 13, bottom: 5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    picture,
                    Spacer(),
                    text,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
