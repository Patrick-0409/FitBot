import 'package:fiton/constant.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
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
            SizedBox(height: 2),
            // Container(
            //   width: Size.width * 0.6,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: kSearchBarColor.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: TextField(),
            // )
          ],
        ),
      ),
    );
  }
}
