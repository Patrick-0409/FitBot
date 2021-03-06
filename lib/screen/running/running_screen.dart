import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/screen/running/components/entry_cart.dart';
import 'package:fiton/screen/running/maps_screen.dart';
import 'package:fiton/models/entry.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:fiton/services/runs_service.dart';
import 'package:flutter/material.dart';

class RunningScreen extends StatefulWidget {
  RunningScreen({Key? key}) : super(key: key);

  @override
  _RunningScreenState createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  List<Entry> _data = [];
  List<EntryCard> _cards = [];

  void initState() {
    super.initState();
    RunsService.init().then((value) => _fetchEntries());
  }

  void _fetchEntries() async {
    _cards = [];
    List userProfilesList = await RunsService().getRuns();
    _data = userProfilesList.map((item) => Entry.fromMap(item)).toList();
    _data.forEach((element) => _cards.add(EntryCard(entry: element)));
    if (this.mounted) {
      setState(() {});
    }
  }

  void _addEntries(Entry en) async {
    String temp = await DailyService().getSingleDaily();
    int tempBurn = await DailyService().getBurnData();
    int newBurn = tempBurn + ((en.distance/1000)*60).toInt();
    FirebaseFirestore.instance.collection('daily').doc(temp).update(
      {
        'burn': newBurn,
      },
    );
    final ref = FirebaseFirestore.instance.collection('runs').doc();
    await ref.set(en.toMap());
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Run History",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 2),
            Container(
              width: size.width,
              height: size.height * 0.82,
              child: ListView(
                children: _cards,
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen()))
            .then((value) => _addEntries(value)),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
