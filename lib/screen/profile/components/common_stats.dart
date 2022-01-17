import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonStats extends StatelessWidget {
  final SvgPicture svg;
  final String text;
  final Color color;
  const CommonStats({
    Key? key,
    required this.svg,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        svg,
        SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: color, fontSize: 14),
        ),
      ],
    );
  }
}
