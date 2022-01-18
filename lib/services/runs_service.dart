import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RunsService {
  final user = FirebaseAuth.instance.currentUser;
  static Future<void> init() async {}

  Future getRuns() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('runs')
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

Future<double> getCalorieAvg() async {
    double temp = 0.0;
    try {
      await FirebaseFirestore.instance
          .collection('runs')
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
            temp += (querySnapshot.docs[i]['distance']/1000)*60;
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

Future<double> getRunAvg() async {
    double temp = 0.0;
    try {
      await FirebaseFirestore.instance
          .collection('runs')
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
            temp += querySnapshot.docs[i]['distance'];
          }
          temp/=querySnapshot.docs.length;
          temp/=1000;
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

  Future getRunWeeks() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('runs')
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
