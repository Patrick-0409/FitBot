import 'package:flutter/material.dart';

import '../../../../constant.dart';

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({required this.icon, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kGrey2),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}
