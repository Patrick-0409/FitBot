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

  void initState() {
    super.initState();
    SchedulesService.init().then(
        (value) => _fetchSchedules(DateFormat.yMd().format(DateTime.now())));
  }

  void _fetchSchedules(String date) async {
    _cards = [];
    List userProfilesList = await SchedulesService().getSchedules(date);
    _data = userProfilesList.map((item) => Schedule.fromMap(item)).toList();
    _data.forEach((element) => _cards.add(ScheduleCard(schedule: element)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.95,
      // color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        color: Colors.white,
      ),
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
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                color: Color(0XFF39BBC3),
                width: 1,
              ),
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 15.0,
                ),
                // Spacer(),
                Text(
                  "Delete",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black, fontSize: 12),
                ),
                Spacer(),
                Text(
                  "Done",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black, fontSize: 12),
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 15.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height * 0.29,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: _cards,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
