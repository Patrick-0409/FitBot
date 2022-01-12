import 'package:fiton/screen/scheduler/Form/add_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskbar extends StatelessWidget {
  const AddTaskbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
