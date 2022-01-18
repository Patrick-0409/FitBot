import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DailyService {
  final user = FirebaseAuth.instance.currentUser;
  static Future<void> init() async {}

  Future getDaily() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('user', isEqualTo: user?.uid)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.length > 0) {
          for (var i = 0; i < querySnapshot.docs.length; i++) {
            itemsList.add(querySnapshot.docs[i].data());
          }
          return itemsList;
        } else {
          return itemsList;
        }
      });
    } catch (e) {
      print(e);
    }
    return itemsList;
  }

Future<String> getSingleDaily() async {
    String temp = "";
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('user', isEqualTo: user?.uid)
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now())).millisecondsSinceEpoch))
          .where('date',
              isLessThan: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)))).millisecondsSinceEpoch))
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.length > 0) {
            // print(querySnapshot.docs[0]['id']);
            // print("ada datanya");
            temp = querySnapshot.docs[0]['id'];
          }else{
            temp = "0";
          }
        },
      );
    } catch (e) {
      print(e);
      temp = "0";
    }
    return temp;
  }

  Future<int> countFood(String time) async {
    int temp = 0;
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('user', isEqualTo: user?.uid)
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now())).millisecondsSinceEpoch))
          .where('date',
              isLessThan: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)))).millisecondsSinceEpoch))
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.length > 0) {
            if(querySnapshot.docs[0][time].length>0){
              // print(querySnapshot.docs[0][time][1]);
              temp = int.parse(querySnapshot.docs[0][time][1]);
            }
            else{
              temp = 0;
            }
          }else{
            temp = 0;
          }
        },
      );
    } catch (e) {
      print(e);
      temp = 0;
    }
    return temp;
  }

  Future<bool> checkFood(String time) async {
    bool temp = false;
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('user', isEqualTo: user?.uid)
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now())).millisecondsSinceEpoch))
          .where('date',
              isLessThan: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)))).millisecondsSinceEpoch))
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.length > 0) {
            if(querySnapshot.docs[0][time].length>0){
              // print(querySnapshot.docs[0][time]);
              temp = true;
            }
            else{
              temp = false;
            }
          }else{
            temp = false;
          }
        },
      );
    } catch (e) {
      print(e);
      temp = false;
    }
    return temp;
  }

  Future<bool> checkDaily() async {
    bool temp = false;
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('user', isEqualTo: user?.uid)
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now())).millisecondsSinceEpoch))
          .where('date',
              isLessThan: Timestamp.fromMillisecondsSinceEpoch(DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1)))).millisecondsSinceEpoch))
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.length > 0) {
            // print(querySnapshot.docs[0]['date']);
            // print("ada datanya");
            temp = true;
          }else{
            temp = false;
          }
        },
      );
    } catch (e) {
      print(e);
      temp = false;
    }
    return temp;
  }

  int _countSleep(String _sleep, String _wake){
    var format = DateFormat("HH:mm");
    var wake = format.parse(_wake);
    var sleep = format.parse(_sleep);
    int diff = sleep.difference(wake).inHours;
    if(diff.isNegative)
      return diff+24;
    return diff; 
  }

  Future<double> getSleepAvg() async {
    double temp = 0.0;
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                  DateFormat.yMd()
                      .parse(DateFormat.yMd().format(
                          DateTime.now().subtract(const Duration(days: 6))))
                      .millisecondsSinceEpoch))
          .where('user', isEqualTo: user?.uid)
          .orderBy('date')
          .get()
          .then((querySnapshot) {
            if (querySnapshot.docs.length > 0) {
              for (var i = 0; i < querySnapshot.docs.length; i++) {
                temp += _countSleep(querySnapshot.docs[i]['sleep'],querySnapshot.docs[i]['wake']);
              }
              temp/=querySnapshot.docs.length;
              return temp;
            } else {
              return temp;
            }
          });
    } catch (e) {
      print(e);
    }
    return temp;
  }

  Future<double> getWeightAvg() async {
    double temp = 0.0;
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                  DateFormat.yMd()
                      .parse(DateFormat.yMd().format(
                          DateTime.now().subtract(const Duration(days: 1))))
                      .millisecondsSinceEpoch))
          .where('user', isEqualTo: user?.uid)
          .orderBy('date')
          .get()
          .then((querySnapshot) {
            if (querySnapshot.docs.length > 0) {
              temp = querySnapshot.docs[1]['weight'].toDouble()-querySnapshot.docs[0]['weight'].toDouble();
              return temp;
            } else {
              return temp;
            }
          });
    } catch (e) {
      print(e);
    }
    return temp;
  }

  Future getDailyWeeks() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('daily')
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                  DateFormat.yMd()
                      .parse(DateFormat.yMd().format(
                          DateTime.now().subtract(const Duration(days: 6))))
                      .millisecondsSinceEpoch))
          .where('user', isEqualTo: user?.uid)
          .orderBy('date')
          .get()
          .then((querySnapshot) {
            if (querySnapshot.docs.length > 0) {
              for (var i = 0; i < querySnapshot.docs.length; i++) {
                itemsList.add(querySnapshot.docs[i].data());
              }
              return itemsList;
            } else {
              return itemsList;
            }
          });
    } catch (e) {
      print(e);
    }
    return itemsList;
  }
}
