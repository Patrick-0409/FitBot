import 'package:fiton/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  EntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kChat,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat.yMMMMd('en_US').format(entry.date),
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  Text((entry.distance / 1000).toStringAsFixed(2) + " km",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.duration,
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  Text(entry.speed.toStringAsFixed(2) + " km/h",
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              )
            ],
          )),
    );
  }
}
