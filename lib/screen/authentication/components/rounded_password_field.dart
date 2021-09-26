import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFieldContainer(
      child: TextFormField(
        key: ValueKey('password'),
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
        validator: (value) {
          if (value!.isEmpty || value.length < 6) {
            return 'Password must be at least 6 characters long.';
          } else {
            return null;
          }
        },
        onSaved: (password) => provider.userPassword = password!,
      ),
    );
  }
}
