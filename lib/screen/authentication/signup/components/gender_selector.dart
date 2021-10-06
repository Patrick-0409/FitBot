import 'package:fiton/screen/provider/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderSelector extends StatefulWidget {
  GenderSelector({Key? key}) : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      provider.gender = _selectedGender;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              groupValue: _selectedGender,
              value: 'male',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value.toString();
                });
                provider.gender = _selectedGender;
              },
            ),
            Text(
              'Male',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            Radio(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              value: 'female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value.toString();
                });
                provider.gender = _selectedGender;
              },

            ),
            Text(
              'Female',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
