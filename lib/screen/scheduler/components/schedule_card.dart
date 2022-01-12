import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiton/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../scheduler_screen.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  ScheduleCard({required this.schedule});

  void _delete(BuildContext context) {
    FirebaseFirestore.instance
        .collection("schedules")
        .doc(schedule.id)
        .delete();
    refreshScreen(context);
  }

  void _done(BuildContext context) {
    FirebaseFirestore.instance
        .collection("schedules")
        .doc(schedule.id)
        .update({"isCompleted": 1});
    refreshScreen(context);
  }

  void refreshScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => SchedulerScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: _delete,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: _done,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Done',
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(schedule.date!,
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text(schedule.isCompleted == 0 ? "Not Yet" : "Done",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
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
      ),
    );
  }
}
