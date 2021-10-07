import 'package:fiton/screen/authentication/components/rounded_login_option.dart';
import 'package:fiton/screen/provider/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RoundedLoginOption(
          text: 'WITH GOOGLE',
          img: 'google',
          press: () {
            final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
          color: Colors.white,
          tcolor: Colors.black,
          height: 30,
        ),
        SizedBox(width: 20),
        RoundedLoginOption(
          text: 'WITH FACEBOOK',
          img: 'facebook',
          press: () {},
          color: kFacebookColor,
          tcolor: Colors.white,
          height: 35,
        )
      ],
    );
  }
}
