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
            margin: EdgeInsets.only(right: 15),
            width: 140,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0XFF3B7C81),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 17, right: 6),
              child: Text(
                " + Add Schedule",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 15,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
