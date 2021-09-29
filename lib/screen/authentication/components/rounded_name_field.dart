import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class RoundedNameField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hint;
  const RoundedNameField({
    Key? key,
    required this.onChanged,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      height: size.height * 0.08,
      width: size.width * 0.5,
      child: TextFormField(
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: kFacebookColor,
          ),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
