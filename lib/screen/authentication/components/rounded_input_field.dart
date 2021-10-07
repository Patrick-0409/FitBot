import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class RoundedInputField extends StatefulWidget {
  RoundedInputField({Key? key, this.onChanged}) : super(key: key);

  final ValueSetter<String?>? onChanged;

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}


class _RoundedInputFieldState extends State<RoundedInputField> {

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      height: size.height * 0.064,
      width: size.width * 0.87,
      child: TextFormField(
        key: ValueKey('email'),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        enableSuggestions: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: kFacebookColor,
          ),
          hintText: 'Your Email',
          border: InputBorder.none,
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
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);
          if (!regExp.hasMatch(value!)) {
            errorWidget = new ErrorIcon(true);
            return '';
          } else {
            errorWidget = new ErrorIcon(false);
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (email) => provider.userEmail = email!,
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
