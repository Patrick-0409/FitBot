import 'package:cloud_firestore/cloud_firestore.dart';
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
