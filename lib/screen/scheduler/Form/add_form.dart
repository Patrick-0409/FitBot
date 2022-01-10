import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/scheduler/Form/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddForm> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM ";
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 0),
                child: Row(
                  children: [
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context),
                      color: kGrey2,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.home,
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
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Schedule",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 24),
                ),
                InputField(
                  title: "Activity Name",
                  hint: "Input Your Activity Name",
                ),
                InputField(
                  title: "Location",
                  hint: "Input Your Location",
                ),
                InputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () async {
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null) {
                        setState(
                          () {
                            _selectedDate = datePick;
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
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: Icon(Icons.access_time_rounded),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
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
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                InputField(
                  title: "Repeat",
                  hint: "$_selectedRepeat",
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
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddForm();
                            },
                          ),
                        );
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
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
          ),
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker(this.context);
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker(BuildContext context) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _colorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: descriptionStyle.copyWith(color: Colors.black, fontSize: 14),
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
