import 'dart:io';

import 'package:fiton/screen/authentication/components/rounded_name_field.dart';
import 'package:fiton/screen/authentication/signup/components/user_image.dart';
import 'package:fiton/services/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../../../constant.dart';

class AvatarName extends StatefulWidget {
  const AvatarName({
    Key? key,
  }) : super(key: key);
  @override
  _AvatarNameState createState() => _AvatarNameState();
}

class _AvatarNameState extends State<AvatarName> {

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
              SizedBox(
                height: 115,
                width: 115,
                child: 
                  UserImage(
                    onFileChanged: (imageUrl) {
                      setState(() {
                        provider.imageUrl = imageUrl == "" ? "https://img.freepik.com/free-photo/young-fitness-man-studio_7502-5008.jpg?size=626&ext=jpg&ga=GA1.2.1278783015.1641168000" : imageUrl;
                      });
                    },
                  ),
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
