import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fiton/screen/scheduler/components/add_taskbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddTaskbar(),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: DatePicker(
              DateTime.now(),
              height: 94,
              width: 75,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: kBackgroundColor,
              dayTextStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.0,
                  color: kBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              monthTextStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12.0,
                  color: kBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onDateChange: (date) {
                _selectedDate = date;
              },
            ),
          ),
        ],
      ),
    );
  }
}
