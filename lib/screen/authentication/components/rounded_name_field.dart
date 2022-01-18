import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class RoundedNameField extends StatefulWidget {
  RoundedNameField({Key? key, this.hint, this.onChanged}) : super(key: key);

  final String? hint;
  final ValueSetter<String?>? onChanged;

  @override
  _RoundedNameFieldState createState() => _RoundedNameFieldState();
}



class _RoundedNameFieldState extends State<RoundedNameField> {

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      height: size.height * 0.064,
      width: size.width * 0.5,
      child: TextFormField(
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: kFacebookColor,
          ),
          hintText: widget.hint,
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
          if (value!.isEmpty) {
            errorWidget = new ErrorIcon(true);
            return '';
          } else {
            errorWidget = new ErrorIcon(false);
            return null;
          }
        },
        onSaved: widget.onChanged,
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