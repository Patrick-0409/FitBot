import 'package:fiton/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  ScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(schedule.date!,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(schedule.title!,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Text(schedule.location!,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Start Time",
                    style: TextStyle(color: Colors.black, fontSize: 14)),
                Text("End Time",
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(schedule.startTime!,
                    style: TextStyle(color: Colors.black, fontSize: 14)),
                Text(schedule.endTime!,
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
