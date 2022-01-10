import 'package:fiton/screen/scheduler/scheduler_screen.dart';
import 'package:flutter/material.dart';

class SchedulerHome extends StatelessWidget {
  const SchedulerHome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
        child: Container(
          width: double.infinity,
          height: size.height,
          margin: EdgeInsets.only(bottom: 240),
          padding: EdgeInsets.only(left: 10),
          // padding: EdgeInsets.only(left: 20, right: 15),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            border: Border.all(
              color: Colors.white,
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
                    .copyWith(color: Colors.black),
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
    );
  }
}
