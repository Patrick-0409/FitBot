import 'package:fiton/screen/authentication/components/rounded_name_field.dart';
import 'package:flutter/material.dart';

class AvatarName extends StatelessWidget {
  const AvatarName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(left: 22, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RoundedNameField(
                onChanged: (value) {},
                hint: 'First Name',
              ),
              SizedBox(height: size.height * 0.01),
              RoundedNameField(
                onChanged: (value) {},
                hint: 'Last Name',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
