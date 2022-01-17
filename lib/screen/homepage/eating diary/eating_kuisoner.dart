import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/daily.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/scheduler/Form/input_field.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/screen/workout/kuisoner/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class EatingKusioner extends StatefulWidget {
  EatingKusioner({Key? key}) : super(key: key);

  @override
  _EatingKusionerState createState() => _EatingKusionerState();
}

class _EatingKusionerState extends State<EatingKusioner> {
  String _breakfastTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _lunchTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _dinnerTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                    hint: _breakfastTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isTime: 1);
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  // SizedBox(width: 12),
                  InputField(
                    title: "Lunch",
                    hint: _lunchTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isTime: 2);
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  InputField(
                    title: "Dinner",
                    hint: _dinnerTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isTime: 3);
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    // onTap: () async {
                    //   if (_formKey.currentState != null &&
                    //       _formKey.currentState!.validate()) {
                    //     Daily dl = Daily(
                    //       date: DateTime.now(),
                    //       sleep: DateFormat.Hm()
                    //           .format(DateFormat.jm().parse(_startTime)),
                    //       wake: DateFormat.Hm()
                    //           .format(DateFormat.jm().parse(_endTime)),
                    //       weight: int.parse(_weightController.text),
                    //       user: user!.uid,
                    //     );
                    //     await _save(dl);
                    //   }
                    // },
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

  _save(Daily dl) async {
    try {
      final ref = FirebaseFirestore.instance.collection('daily').doc();
      await ref.set(dl.toMap(ref.id));
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

  String? _requiredWeight(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    if (int.parse(text) < 5) {
      return "Enter weight correctly!";
    }
    if (int.parse(text) > 300) {
      return "Enter weight correctly!";
    }
    return null;
  }

  _getTimeFromUser({required int isTime}) async {
    var pickedTime = await _showTimePicker(this.context);
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled");
    } else if (isTime == 1) {
      setState(() {
        _breakfastTime = _formatedTime;
      });
    } else if (isTime == 2) {
      setState(() {
        _lunchTime = _formatedTime;
      });
    } else if (isTime == 3) {
      setState(() {
        _dinnerTime = _formatedTime;
      });
    }
  }

  _showTimePicker(BuildContext context) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
    );
  }
}