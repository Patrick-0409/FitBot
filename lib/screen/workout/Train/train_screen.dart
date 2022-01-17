import 'package:fiton/models/fitness.dart';
import 'package:fiton/models/movement.dart';
import 'package:fiton/models/user.dart';
import 'package:fiton/screen/eat/detail/components/circle_button.dart';
import 'package:fiton/screen/workout/Train/components/fitness_card.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/screen/workout/Train/train_detail_screen.dart';
import 'package:fiton/services/movement_service.dart';
import 'package:fiton/services/fitness_service.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class TrainScreen extends StatefulWidget {

  TrainScreen(
      {Key? key, required this.user})
      : super(key: key);
  UserStore user;
  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  List<Fitness> fitnessList = [];

  @override
  void initState() {
    fetchFitnessList();
    super.initState();
  }
  
  fetchFitnessList() async {
    List temp = await FitnessService().getFitness();
    fitnessList = temp.map((item) => Fitness.fromMap(item)).toList();
    return fitnessList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
                child: Row(
                  children: [
                    CircleButton(
                      icon: Icons.arrow_back_ios,
                      onTap: () => Navigator.pop(context),
                      color: kGrey2,
                    ),
                    Spacer(),
                    Text(
                      "FitBot",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    HomeButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Training',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 24),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(bottom: 85),
                  width: double.infinity,
                  height: size.height,
                  child: FutureBuilder(
                    future: fetchFitnessList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: fitnessList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var recent = fitnessList[index];
                            return InkWell(
                              onTap: () async {
                                List tempList = await MovementService().getMovement(fitnessList[index].movement);
                                List<Movement> movementList = tempList.map((item) => Movement.fromMap(item)).toList();
                                Navigator.push(
                                  context,  
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TrainDetailScreen(
                                        name: fitnessList[index].name,
                                        level: widget.user.difficulty! == "" ? "medium" : widget.user.difficulty!,
                                        minute: fitnessList[index].minute,
                                        imageUrl: fitnessList[index].imageUrl,
                                        round: widget.user.difficulty! == "easy" ? fitnessList[index].easy[0] : widget.user.difficulty! == "medium" ? fitnessList[index].medium[0] : fitnessList[index].hard[0],
                                        second: widget.user.difficulty! == "easy" ? fitnessList[index].easy[1] : widget.user.difficulty! == "medium" ? fitnessList[index].medium[1] : fitnessList[index].hard[1],
                                        movement: movementList,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FitnessCard(fitness: recent),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
