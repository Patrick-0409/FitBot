import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiton/models/schedule.dart';
import 'package:fiton/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../scheduler_screen.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  ScheduleCard({required this.schedule});

  void _delete(BuildContext context) {
    FirebaseFirestore.instance
        .collection("schedules")
        .doc(schedule.id)
        .delete();
    SchedulesService().setNotifSchedules();
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
    Size size = MediaQuery.of(context).size;
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
        margin: EdgeInsets.all(0),
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          width: size.width,
          height: size.height * 0.13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: schedule.color == 0
                  ? Colors.orange
                  : schedule.color == 1
                      ? Colors.blueAccent
                      : Colors.red),
          padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: size.width * 0.63,
                    margin: EdgeInsets.all(0),
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        // SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            SizedBox(width: 5),
                            Text(
                              schedule.location!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            SizedBox(width: 5),
                            Text(
                              schedule.startTime!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Text(
                              schedule.endTime!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    schedule.isCompleted == 0 ? "Not Yet" : "Done",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
