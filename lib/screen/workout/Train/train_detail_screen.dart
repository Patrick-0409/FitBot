import 'dart:ui';
import 'package:fiton/constant.dart';
import 'package:fiton/models/movement.dart';
import 'package:fiton/models/workout_data.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/screen/workout/Train/components/round_info_container.dart';
import 'package:fiton/screen/workout/Train/train_timer.dart';
import 'package:flutter/material.dart';

class TrainDetailScreen extends StatelessWidget {
  TrainDetailScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.minute,
    required this.round,
    required this.second,
    required this.level,
    required this.movement,
    required this.burn,
  }) : super(key: key);

  String name;
  String imageUrl;
  int minute;
  int round;
  int second;
  String level;
  int burn;
  List<Movement> movement;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                    child: Container(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                      HomeButton(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundInfoContainer(
                            title: minute.toString(),
                            subtitle: 'Minutes',
                          ),
                          _divider(),
                          RoundInfoContainer(
                            title: round.toString(),
                            subtitle: 'Rounds',
                          ),
                          _divider(),
                          RoundInfoContainer(
                            title: level,
                            subtitle: 'Level',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(left: 16, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Round 1',
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                ),
                Text(
                  'Full Body',
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movement.length,
              itemBuilder: (context, index) {
                // print(movement[index].times);
                // print(index);
                return ListTile(
                  isThreeLine: true,
                  leading: Container(
                    width: 90,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movement[index].gifUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  title: Text(
                    movement[index].name,
                    style: descriptionStyle.copyWith(
                        color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    '00:$second',
                    style: descriptionStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TrainTimer(
                  name: name,
                  second: second,
                  movement: movement,
                  burn: burn,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: EdgeInsets.only(bottom: 10),
              width: size.width * 0.92,
              decoration: BoxDecoration(
                color: kBackgroundColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Start workout',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1.2,
      height: 35,
      color: Colors.white.withOpacity(.6),
    );
  }
}
