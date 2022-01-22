import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/models/schedule.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/scheduler/Form/input_field.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime _startTime = (DateTime.now()).add(Duration(minutes: 5));
  DateTime _endTime = (DateTime.now()).add(Duration(hours: 1,minutes: 5));
  int _selectedRemind = 0;
  List<int> remindList = [0, 5, 10, 15, 20];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
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
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context, null),
                      color: kGrey2,
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
                      "Add Schedule",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 24, color: Colors.white),
                    ),
                    InputField(
                      title: "Activity Name",
                      hint: "Input Your Activity Name",
                      controller: _titleController,
                      validator: _requiredText,
                    ),
                    InputField(
                      title: "Location",
                      hint: "Input Your Location",
                      controller: _locationController,
                      validator: _requiredText,
                    ),
                    InputField(
                      title: "Start Date",
                      hint: DateFormat.yMd().format(_startDate),
                      widget: IconButton(
                        onPressed: () async {
                          final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100),
                          );
                          if (datePick != null) {
                            setState(
                              () {
                                _startDate = datePick;
                              },
                            );
                          }
                        },
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    InputField(
                      title: "End Date",
                      hint: DateFormat.yMd().format(_endDate),
                      widget: IconButton(
                        onPressed: () async {
                          final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100),
                          );
                          if (datePick != null) {
                            setState(
                              () {
                                _endDate = datePick;
                              },
                            );
                          }
                        },
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputField(
                            title: "Start Time",
                            hint: DateFormat.Hm().format(_startTime).toString(),
                            widget: IconButton(
                              onPressed: () {
                                _getTimeFromUser('start');
                              },
                              icon: Icon(Icons.access_time_rounded),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: InputField(
                            title: "End Time",
                            hint: DateFormat.Hm().format(_endTime).toString(),
                            widget: IconButton(
                              onPressed: () {
                                _getTimeFromUser('end');
                              },
                              icon: Icon(Icons.access_time_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InputField(
                      title: "Remind",
                      hint: "$_selectedRemind minutes early",
                      widget: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 22,
                          elevation: 4,
                          style: descriptionStyle.copyWith(
                              color: Colors.grey, fontSize: 14, height: 2),
                          underline: Container(height: 0),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue!);
                            });
                          },
                          items: remindList
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        _colorSelection(),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              Schedule sc = Schedule(
                                title: _titleController.text,
                                location: _locationController.text,
                                startDate: DateFormat.yMd().format(_startDate),
                                endDate: DateFormat.yMd().format(_endDate),
                                startTime: DateFormat.Hm()
                                    .format(_startTime),
                                endTime: DateFormat.Hm()
                                    .format(_endTime),
                                color: _selectedColor,
                                remind: _selectedRemind,
                                isCompleted: 0,
                                uid: user?.uid,
                              );
                              SchedulesService().setNotifSchedules();
                              Navigator.pop(context, sc);
                            }
                          },
                          child: Container(
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0XFF3B7C81),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, right: 5),
                              child: Text(
                                " Create Schedule",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  String? _requiredText(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    if (text.length < 3 || text.length > 24) {
      return "Please enter 3 until 24 characters!";
    }
    return null;
  }

  _getTimeFromUser(String activity) async {
    TimeOfDay pickedTime = await _showTimePicker(this.context,activity);
    if (pickedTime == null) {
      print("Time Canceled");
    } else {
      String _formatedTime =
          pickedTime.hour.toString() + ":" + pickedTime.minute.toString();
      print(_formatedTime);
      if (activity == "start") {
        setState(() {
          _startTime = DateFormat.Hm().parse(_formatedTime);
        });
      } else if (activity == "end") {
        setState(() {
          _endTime = DateFormat.Hm().parse(_formatedTime);
        });
      }
    }
  }

  _showTimePicker(BuildContext context,String activity) {
    if (activity == "start")
      return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay.fromDateTime(_startTime),
      );

    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.fromDateTime(_endTime),
    );
  }

  _colorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: descriptionStyle.copyWith(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 5),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                    print("$index");
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? Colors.orange
                        : index == 1
                            ? Colors.blueAccent
                            : Colors.red,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
