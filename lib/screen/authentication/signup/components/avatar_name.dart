import 'package:fiton/screen/authentication/components/rounded_name_field.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarName extends StatelessWidget {
  const AvatarName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                maxRadius: 60,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 13.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RoundedNameField(
                onChanged: (firstName) => provider.firstName = firstName!,
                hint: 'First Name',
              ),
              SizedBox(height: size.height * 0.01),
              RoundedNameField(
                onChanged: (lastName) => provider.lastName = lastName!,
                hint: 'Last Name',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
