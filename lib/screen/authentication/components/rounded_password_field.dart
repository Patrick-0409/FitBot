import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/services/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';

class RoundedPasswordField extends StatefulWidget {
  RoundedPasswordField({Key? key, this.onChanged}) : super(key: key);

  final ValueSetter<String?>? onChanged;

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      height: size.height * 0.064,
      width: size.width * 0.87,
      child: TextFormField(
        key: ValueKey('password'),
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: kFacebookColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: kFacebookColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: InputBorder.none,
          hintText: "Your Password",
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          errorStyle: TextStyle(fontSize: 0, height: 0),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || value.length < 6) {
            return '';
          } else {
            return null;
          }
        },
        onChanged: widget.onChanged,
        onSaved: (password) => provider.userPassword = password!,
      ),
    );
  }
}
