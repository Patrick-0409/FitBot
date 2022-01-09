import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/authentication/signup/components/dob_selector.dart';
import 'package:fiton/screen/authentication/signup/components/gender_selector.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Workout Plan",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontSize: 22),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 15, right: 15),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Before we start,",
      //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
      //                 fontWeight: FontWeight.w600,
      //               ),
      //         ),
      //         Text(
      //           "Let's fill some missing things",
      //           style: Theme.of(context)
      //               .textTheme
      //               .bodyText1!
      //               .copyWith(fontWeight: FontWeight.w600),
      //         ),
      //         SizedBox(height: 10),
      //         Container(
      //           height: size.height * 0.5,
      //           width: size.width * 0.95,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(
      //                 color: kBackgroundColor,
      //                 width: 1,
      //               ),
      //               color: kBackgroundColor),
      //           child: Padding(
      //             padding: const EdgeInsets.only(
      //                 left: 10.0, right: 10, top: 10, bottom: 10),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 DobSelector(),
      //                 SizedBox(height: 5),
      //                 GenderSelector(),
      //                 SizedBox(height: 5),
      //                 Row(
      //                   children: [
      //                     TextFieldContainer(
      //                       height: size.height * 0.064,
      //                       width: size.width * 0.42,
      //                       child: TextField(
      //                         decoration: InputDecoration(
      //                           contentPadding:
      //                               EdgeInsets.only(left: 10, bottom: 10),
      //                           hintText: "Weight(kg)",
      //                         ),
      //                       ),
      //                     ),
      //                     Spacer(),
      //                     TextFieldContainer(
      //                       height: size.height * 0.064,
      //                       width: size.width * 0.42,
      //                       child: TextField(
      //                         decoration: InputDecoration(
      //                           contentPadding:
      //                               EdgeInsets.only(left: 10, bottom: 10),
      //                           hintText: "Height(cm)",
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10),
      //         Text(
      //           "The data you provide will be used to adapt our training plan based on your input",
      //           textAlign: TextAlign.center,
      //           style: Theme.of(context)
      //               .textTheme
      //               .bodyText1!
      //               .copyWith(fontWeight: FontWeight.w600),
      //         ),
      //         SizedBox(height: 10),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 13),
      //           child: RoundedButton(
      //             text: "Submit",
      //             press: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) {
      //                     return HomeScreen();
      //                   },
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
