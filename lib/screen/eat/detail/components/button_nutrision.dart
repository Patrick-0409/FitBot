import 'package:flutter/material.dart';

import '../../../../constant.dart';

class ButtonNutrision extends StatelessWidget {
  const ButtonNutrision({
    Key? key,
    required this.size,
    required this.name,
    required this.quantity,
  }) : super(key: key);

  final Size size;
  final String name;
  final num quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.29,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: descriptionStyle.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.3,
                  ),
                ),
                Text(
                  "gram",
                  textAlign: TextAlign.start,
                  style: descriptionStyle.copyWith(
                    color: KNutrisionColor,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: size.width * 0.11,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: KNutrisionValueColor,
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: Text(
                quantity.toStringAsFixed(1),
                textAlign: TextAlign.center,
                style: descriptionStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  height: 2,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
