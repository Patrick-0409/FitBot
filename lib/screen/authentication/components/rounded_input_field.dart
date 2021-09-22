import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: kFacebookColor,
          ),
          hintText: 'Your Email',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
