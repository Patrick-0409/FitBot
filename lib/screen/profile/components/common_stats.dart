import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonStats extends StatelessWidget {
  final SvgPicture svg;
  final String text;
  const CommonStats({
    Key? key,
    required this.svg,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // SvgPicture.asset("assets/images/weight.svg"),
        svg,
        SizedBox(width: 20),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
