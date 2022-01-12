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

  Future getRunWeeks() async {
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('runs')
            .where('date', isGreaterThanOrEqualTo: DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(const Duration(days: 7))))
            .where('user', isEqualTo: user?.uid)
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