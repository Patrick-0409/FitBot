import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

class DobSelector extends StatefulWidget {
  DobSelector({Key? key}) : super(key: key);

  @override
  _DobSelectorState createState() => _DobSelectorState();
}

class _DobSelectorState extends State<DobSelector> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    String birthDateInString;
    bool isDateSelected = false;
    late DateTime birthDate;
    return TextFieldContainer(
      height: size.height * 0.08,
      width: size.width * 0.87,
      child: TextFormField(
        readOnly: true,
        onTap: () async {
          final datePick = await showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime(1900),
              lastDate: new DateTime(2100)
          );
          if (datePick != null) {
            setState(
              () {
                birthDate = datePick;
                isDateSelected = true;
                // put it here
                birthDateInString =
                    "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                provider.dob = birthDate;
              },
            );
          }
        },
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          icon: Icon(
            Icons.date_range_rounded,
            color: kFacebookColor,
          ),
          border: InputBorder.none,
          hintText: 'Your Birthday',
        ),
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please pick your birthdate!';
        //   } else {
        //     return null;
        //   }
        // },
      ),
    );
  }
}
