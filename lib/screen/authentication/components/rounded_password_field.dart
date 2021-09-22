import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: kFacebookColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kFacebookColor,
          ),
          border: InputBorder.none,
          hintText: "Your Password",
        ),
      ),
    );
  }
}
