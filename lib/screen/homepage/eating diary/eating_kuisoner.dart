import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/scheduler/Form/input_field.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class EatingKuisioner extends StatefulWidget {
  EatingKuisioner({Key? key}) : super(key: key);

  @override
  _EatingKuisionerState createState() => _EatingKuisionerState();
}

class _EatingKuisionerState extends State<EatingKuisioner> {
  DateTime _breakfastTime = DateFormat.Hm().parse('07:00');
  DateTime _lunchTime = DateFormat.Hm().parse('12:00');
  DateTime _dinnerTime = DateFormat.Hm().parse('19:00');

  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
                child: Row(
                  children: [
                    Text(
                      "FitBot",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    HomeButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Eating Schedule",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                  ),
                  InputField(
                    title: "Breakfast",
                    hint: DateFormat.Hm().format(_breakfastTime).toString(),
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser("breakfast");
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  // SizedBox(width: 12),
                  InputField(
                    title: "Lunch",
                    hint: DateFormat.Hm().format(_lunchTime).toString(),
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser("lunch");
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  InputField(
                    title: "Dinner",
                    hint: DateFormat.Hm().format(_dinnerTime).toString(),
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser("dinner");
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      String breakfast = DateFormat.Hm().format(_breakfastTime);
                      String lunch = DateFormat.Hm().format(_lunchTime);
                      String dinner = DateFormat.Hm().format(_dinnerTime);
                      NotificationService.showDailyScheduledNotification(
                        id: 21,
                        title: 'FitOn',
                        body:
                            'Don\'t forget to eat breakfast, and have a good day!',
                        payload: 'schedule',
                        scheduledTime: breakfast,
                      );
                      NotificationService.showDailyScheduledNotification(
                        id: 22,
                        title: 'FitOn',
                        body: 'It\'s time for your lunch, don\'t miss it!',
                        payload: 'schedule',
                        scheduledTime: lunch,
                      );
                      NotificationService.showDailyScheduledNotification(
                        id: 23,
                        title: 'FitOn',
                        body:
                            'It\'s dinner time, and after that have a good rest!',
                        payload: 'schedule',
                        scheduledTime: dinner,
                      );
                      _save(breakfast, lunch, dinner);
                    },
                    child: Container(
                      width: size.width,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0XFF3B7C81),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          " Submit",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _save(String breakfast, String lunch, String dinner) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update(
        {
          'breakfast': breakfast,
          'lunch': lunch,
          'dinner': dinner,
        },
      );
    } catch (e) {
      print(e.toString());
    }
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Submit succeeded'),
        content: Text('Thank you for completing your data!'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'))
        ],
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
      ModalRoute.withName("/"),
    );
  }

  _getTimeFromUser(String time) async {
    TimeOfDay pickedTime = await _showTimePicker(this.context, time);
    if (pickedTime == null) {
      print("Time Canceled");
    } else {
      String _formatedTime =
          pickedTime.hour.toString() + ":" + pickedTime.minute.toString();
      if (time == "breakfast") {
        setState(() {
          _breakfastTime = DateFormat.Hm().parse(_formatedTime);
        });
      } else if (time == "lunch") {
        setState(() {
          _lunchTime = DateFormat.Hm().parse(_formatedTime);
        });
      } else if (time == "dinner") {
        setState(() {
          _dinnerTime = DateFormat.Hm().parse(_formatedTime);
        });
      }
    }
  }

  _showTimePicker(BuildContext context, String activity) {
    if (activity == "breakfast")
      return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay.fromDateTime(_breakfastTime),
      );
    else if (activity == "lunch")
      return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay.fromDateTime(_lunchTime),
      );

    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.fromDateTime(_dinnerTime),
    );
  }
}
