import 'dart:async';

import 'package:fiton/constant.dart';
import 'package:fiton/models/movement.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/timer_button.dart';
import 'package:flutter/material.dart';

import 'components/home_button.dart';

class TrainTimer extends StatefulWidget {
  TrainTimer({Key? key, required this.second, required this.movement}) : super(key: key);
  int second;
  List<Movement> movement;
  @override
  _TrainTimerState createState() => _TrainTimerState();
}

class _TrainTimerState extends State<TrainTimer> {
  static const maxSeconds = 60;
  int seconds=0;
  Timer? timer;

  void initState() {
    super.initState();
    startTimer();
  }

  void resetTimer() {
    return setState(() {
      seconds = widget.second;
    });
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 5, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
                HomeButton(),
              ],
            ),
          ),
          Spacer(),
          Image.network('https://c.tenor.com/h9W4zejLjTMAAAAC/fit-workout.gif'),
          Spacer(),
          buildIndicator(),
          SizedBox(height: 30),
          Container(
            height: size.height * 0.33,
            width: size.width,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Timer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                // SizedBox(height: 10),
                buildTime(),
                // SizedBox(height: 5),
                buildButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    Size size = MediaQuery.of(context).size;
    // final isCompleted = seconds == 0 || seconds == maxSeconds;
    // final isRunning = timer == null ? false : timer!.isActive;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.02,
        child: LinearProgressIndicator(
          value: seconds / maxSeconds,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF39BBC3)),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }

  Widget buildTime() {
    // if (seconds == 0) {
    //   resetTimer();
    // } else {
    //   return Text(
    //     '$seconds',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 32.0,
    //       // fontWeight: FontWeight.bold,
    //     ),
    //   );
    // }

    return Text(
      '$seconds',
      style: TextStyle(
        color: Colors.white,
        fontSize: 50.0,
        // fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == 0 || seconds == maxSeconds;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {},
              ),
              SizedBox(width: 10),
              TimerButton(
                text: isRunning ? "Pause" : "Resume",
                press: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
                color: isRunning ? kLoginColor : Color(0XFFc75255),
              ),
              SizedBox(width: 10),
              TimerButton(
                text: "Restart",
                press: () {
                  stopTimer();
                },
                color: Colors.green,
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(
                  Icons.fast_forward,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {},
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {

                },
              ),
              SizedBox(width: 10),
              TimerButton(
                text: "Start",
                press: () {
                  startTimer();
                },
                color: kLoginColor,
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(
                  Icons.fast_forward,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  
                },
              ),
            ],
          );
  }
}
