import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFieldContainer(
      child: TextFormField(
        key: ValueKey('email'),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        enableSuggestions: false,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: kFacebookColor,
          ),
          hintText: 'Your Email',
          border: InputBorder.none,
        ),
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);
          if (!regExp.hasMatch(value!)) {
            return 'Enter a valid mail';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (email) => provider.userEmail = email!,
      ),
    );
  }
}
