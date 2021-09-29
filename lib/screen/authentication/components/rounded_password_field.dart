import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class RoundedPasswordField extends StatefulWidget {
  RoundedPasswordField({Key? key}) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      height: size.height * 0.08,
      width: size.width * 0.87,
      child: TextFormField(
        key: ValueKey('password'),
        obscureText: !_passwordVisible,
        onChanged: (value) {},
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: kFacebookColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: kFacebookColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
                // print(_passwordVisible);
              });
            },
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
