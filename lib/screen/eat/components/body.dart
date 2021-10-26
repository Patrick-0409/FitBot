import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: <Widget>[
            Text(
              "Dishes",
              textAlign: TextAlign.start,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 24),
            ),
            SizedBox(height: 1),
            Text(
              "Lunch Time!",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
