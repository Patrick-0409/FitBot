import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:flutter/material.dart';

class TextFieldd extends StatelessWidget {

  final TextEditingController controller;
  final Size size;
  final String label;
  final bool password;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const TextFieldd({
    required this.label,
    required this.size,
    required this.controller,
    this.validator,
    this.password = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: size.height * 0.064,
      width: size.width * 0.42,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 10, bottom: 10),
          hintText: label,
        ),
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}