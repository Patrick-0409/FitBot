import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/movement.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/timer_button.dart';
import 'package:fiton/screen/workout/Train/feedback_screen.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wakelock/wakelock.dart';

import 'components/home_button.dart';

class TrainTimer extends StatefulWidget {
  TrainTimer({
    Key? key,
    required this.second,
    required this.movement,
    required this.name,
    required this.burn,
    required this.round,
  }) : super(key: key);
  int second;
  List<Movement> movement;
  String name;
  int burn;
  int round;
  @override
  _TrainTimerState createState() => _TrainTimerState();
}

class _TrainTimerState extends State<TrainTimer> {
  int seconds = 1;
  int order = 0;
  int orderTemp = 0;
  int round = 0;
  int roundTemp = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    resetTimer();
    Wakelock.enable();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      nextRound("first");
    });
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

    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      if (seconds > 0) {
        if (this.mounted) {
          setState(() {
            seconds--;
          });
        }
      } else {
        orderTemp++;
        if (orderTemp == widget.movement.length) {
          roundTemp++;
          if (roundTemp == widget.round) {
            String temp = await DailyService().getSingleDaily();
            int tempBurn = await DailyService().getBurnData();
            int newBurn = tempBurn + widget.burn;
            FirebaseFirestore.instance.collection('daily').doc(temp).update(
              {
                'burn': newBurn,
              },
            );
            _tq();
          } else {
            order = 0;
            orderTemp = 0;
            round = roundTemp;
            nextRound("break");
          }
        } else {
          order = orderTemp;
          alert();
        }
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    if (this.mounted) {
      setState(() {
        timer?.cancel();
      });
    }
  }

  void nextRound(String start) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: start == "first" ? 5 : 30), () {
          Navigator.of(context).pop(true);
          alert();
        });
        if (start == "first")
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                  'Let\'s get ready for ${round + 1} Round, we\'ll start in 5 seconds!'),
            ),
          );
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
                'Let\'s get ready for ${round + 1} Round, we\'ll start in 30 seconds!'),
          ),
        );
      },
    );
  }

  void alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
          startTimer();
        });
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Let\'s get ready, we\'ll start in 5 seconds!'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
                Column(
                  children: [
                    Text(
                      widget.movement[order].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                HomeButton(),
              ],
            ),
          ),
          Spacer(),
          Image.network(widget.movement[order].gifUrl),
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
                buildTime(),
                buildButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.02,
        child: LinearProgressIndicator(
          value: seconds / widget.second,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF39BBC3)),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
        color: Colors.white,
        fontSize: 50.0,
        // fontWeight: FontWeight.bold,
      ),
    );
  }

  void _tq() async {
    await showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have finished your workout today!'),
          actions: [
            TextButton(
                onPressed: () {
                  Wakelock.disable();
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    ModalRoute.withName('/'),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FeedbackScreen(
                        name: widget.name,
                      ),
                    ),
                  );
                },
                child: Text('Ok'))
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == 0 || seconds == widget.second;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              TimerButton(
                text: "Start",
                press: () {
                  alert();
                },
                color: kLoginColor,
              ),
              SizedBox(width: 10),
            ],
          );
  }
}
