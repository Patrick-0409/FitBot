import 'package:fiton/constant.dart';
import 'package:flutter/material.dart';

import 'common_stats.dart';
import 'description.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.53,
                      height: size.height * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Container(
                        width: size.width * 0.35,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kGender,
                        ),
                        child: Text(
                          "Male",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Description(size: size),
                SizedBox(height: 10),
                Container(
                  width: size.width,
                  height: size.height * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kProfile,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        child: Text(
                          "Stats This Week",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPip,
                        ),
                        child: Column(
                          children: <Widget>[],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
