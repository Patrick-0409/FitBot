import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/models/schedule.dart';
import 'package:fiton/screen/scheduler/Form/add_form.dart';
import 'package:fiton/screen/scheduler/components/add_taskbar.dart';
import 'package:fiton/screen/scheduler/components/schedule_card.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SchedulerScreen extends StatefulWidget {
  SchedulerScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  List<Schedule> _data = [];
  List<ScheduleCard> _cards = [];
  int count = 0;
  DateTime _selectedDate = DateTime.now();

  void initState() {
    super.initState();
    SchedulesService.init().then(
        (value) => _fetchSchedules(DateFormat.yMd().format(_selectedDate)));
  }

  void _fetchSchedules(String date) async {
    _cards = [];
    List userProfilesList = await SchedulesService().getSchedules(date);
    _data = userProfilesList.map((item) => Schedule.fromMap(item)).toList();
    _data.forEach((element) => _cards.add(ScheduleCard(schedule: element)));
    count = 0;
    setState(() {});
  }

  void _addSchedules(Schedule sc) async {
    final ref = FirebaseFirestore.instance.collection('schedules').doc();
    await ref.set(sc.toMap(ref.id));
    _fetchSchedules(DateFormat.yMd().format(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Schedule",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: kHeaderColor, fontSize: 30),
              ),
              Spacer(),
              HomeButton(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  if (count == 0) {
                    _selectedDate = date;
                    _fetchSchedules(DateFormat.yMd().format(date));
                  }
                  count++;
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
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
                        .copyWith(color: Colors.black, fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    "Done",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black, fontSize: 14),
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
            Container(
              width: size.width,
              height: size.height * 0.65,
              padding: EdgeInsets.only(bottom: 5),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: _cards,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddForm(),
          ),
        ).then((value) {
          if (value != null) _addSchedules(value);
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
