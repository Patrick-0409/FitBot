import 'package:flutter/material.dart';

class AccountChecker extends StatelessWidget {
  final bool login;
  final Function() press;
  const AccountChecker({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have Account ? " : "Already have an Account ? ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
        )
      ],
    );
  }
}
