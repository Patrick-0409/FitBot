import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

class DobSelector extends StatefulWidget {
  DobSelector({Key? key}) : super(key: key);

  @override
  _DobSelectorState createState() => _DobSelectorState();
}

class _DobSelectorState extends State<DobSelector> {

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

  TextEditingController TEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    late String birthDateInString;
    bool isDateSelected = false;
    late DateTime birthDate;
    return TextFieldContainer(
      height: size.height * 0.064,
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
                    "${birthDate.day}-${birthDate.month}-${birthDate.year}"; // 08/14/2019
                provider.dob = birthDate;
                TEController.text=birthDateInString;
              },
            );
          }
        },
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.date_range_rounded,
            color: kFacebookColor,
          ),
          border: InputBorder.none,
          hintText: 'Your Birthday',
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          errorStyle: TextStyle(fontSize: 10, height: 0),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: _errorWidget,
        ),
        controller: TEController,
        validator: (value) {
          if (value!.isEmpty) {
            errorWidget = new ErrorIcon(true);
            return '';
          } else {
            errorWidget = new ErrorIcon(false);
            return null;
          }
        },
      ),
    );
  }
}

class ErrorIcon extends StatelessWidget {
  bool _isError;

  ErrorIcon(this._isError);

  bool get isError => _isError;

  @override
  Widget build(BuildContext context) {
    Widget out;

    debugPrint("Rebuilding ErrorWidget");
    isError
        ? out = new Icon(
      Icons.error,
      color: Color(Colors.red.value),
    )
        : out = new Icon(null);

    return out;
  }
}