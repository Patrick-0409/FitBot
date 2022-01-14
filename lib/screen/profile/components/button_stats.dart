import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonStats extends StatelessWidget {
  const ButtonStats({
    Key? key,
    required this.size,
    required this.picture,
    required this.text,
    required this.press,
  }) : super(key: key);

  final Size size;
  final SvgPicture picture;
  final Text text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        // height: size.height * 0.5,
        width: size.width * 0.35,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      picture,
                      Spacer(),
                      text,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
