import 'package:fiton/constant.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/answer_button.dart';
import 'package:fiton/services/user_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({
    Key? key,
    required this.name,
  }) : super(key: key);
  String name;

  @override
  Widget build(BuildContext context) {
    void _tq() async {
      await showDialog(
        context: context,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Thank you!'),
            content: Text('We will adjust the workout to your ability.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Text('Ok'))
            ],
          ),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
                child: Text(
                  "FitBot",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          margin: EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.white,
                    ),
              ),
              Text(
                "Completed",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Colors.white,
                    ),
              ),
              SizedBox(height: 30),
              Text(
                "What do you think about the workout ?",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
              SizedBox(height: 10),
              AnswerButton(
                text: "Easy, no problem",
                press: () {
                  UserService().setDifficulty("hard");
                  _tq();
                },
              ),
              AnswerButton(
                text: "Hard but doable",
                press: () {
                  UserService().setDifficulty("medium");
                  _tq();
                },
              ),
              AnswerButton(
                text: "Extremely tough",
                press: () {
                  UserService().setDifficulty("easy");
                  _tq();
                },
              ),
              SizedBox(height: 50),
              Text(
                "We will customize the next workout\n plan based on your feedback",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
