import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:fiton/models/schedule.dart';
import 'package:fiton/screen/scheduler/components/schedule_card.dart';
import 'package:fiton/screen/scheduler/scheduler_screen.dart';
import 'package:fiton/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class SchedulerHome extends StatefulWidget {
  final Size size;
  SchedulerHome({Key? key, required this.size}) : super(key: key);

  @override
  _SchedulerHomeState createState() => _SchedulerHomeState();
}

class _SchedulerHomeState extends State<SchedulerHome> {
  List<Schedule> _data = [];
  List<ScheduleCard> _cards = [];
  DateTime _selectedDate = DateTime.now();

  void _fetchSchedules(String date) async {
    _cards = [];
    List userProfilesList = await SchedulesService().getSchedules(date);
    _data = userProfilesList.map((item) => Schedule.fromMap(item)).toList();
    _data.forEach((element) => _cards.add(ScheduleCard(schedule: element)));
    setState(() {});
  }

  void initState() {
    super.initState();
    SchedulesService.init().then(
        (value) => _fetchSchedules(DateFormat.yMd().format(DateTime.now())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.95,
      // color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SchedulerScreen();
              },
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.046,
              // margin: EdgeInsets.only(bottom: 236),
              padding: EdgeInsets.only(left: 10),
              // padding: EdgeInsets.only(left: 20, right: 15),
              decoration: BoxDecoration(
                color: Color(0XFF39BBC3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                border: Border.all(
                  color: Color(0XFF39BBC3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Schedule",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              height: size.height * 0.11,
              margin: EdgeInsets.only(left: 10),
              // padding: EdgeInsets.only(bottom: 0),
              child: DatePicker(
                DateTime.now(),
                height: size.height * 0.139,
                width: 75,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: kBackgroundColor,
                dayTextStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 10.0,
                    color: kBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                monthTextStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 10.0,
                    color: kBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                dateTextStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    color: kBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onDateChange: (date) {
                  _selectedDate = date;
                  _fetchSchedules(DateFormat.yMd().format(date));
                },
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.23,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: _cards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
