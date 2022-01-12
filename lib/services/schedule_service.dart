import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SchedulesService {
  final user = FirebaseAuth.instance.currentUser;
  static Future<void> init() async {}

  Future getSchedules(String date) async {
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('schedules')
            .where('uid', isEqualTo: user?.uid)
            .where('date', isEqualTo: date)
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
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