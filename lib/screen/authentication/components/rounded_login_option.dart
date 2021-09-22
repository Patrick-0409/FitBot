import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedLoginOption extends StatelessWidget {
  final String text, img;
  final double height;
  final Function() press;
  final Color color, tcolor;
  const RoundedLoginOption({
    Key? key,
    required this.text,
    required this.img,
    required this.press,
    required this.color,
    required this.tcolor,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 170,
        height: 50,
        // button width and height
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: color, // button color
            child: InkWell(
              splashColor: Colors.black26, // splash color
              onTap: press, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10),
                      SvgPicture.asset(
                        "assets/icons/$img.svg",
                        height: height,
                        width: 20,
                      ),
                      SizedBox(width: 15),
                      Text(text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: tcolor)),
                    ],
                  )
                  // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
