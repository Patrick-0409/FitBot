import 'dart:io';

import 'package:fiton/screen/authentication/components/rounded_name_field.dart';
import 'package:fiton/screen/authentication/signup/components/user_image.dart';
import 'package:fiton/screen/provider/email_auth.dart';
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
  File? image;
  String? basename;
  String? imageUrl;

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
                        provider.urlImage = imageUrl;
                        this.imageUrl = imageUrl;
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

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      this.basename = p.basename(image.path);
      print(this.basename);
    } on PlatformException catch (e){
      print('Failed to pick image $e');
    }
  }
}
