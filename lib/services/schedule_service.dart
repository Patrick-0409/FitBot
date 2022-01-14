import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/services/notification_service.dart';
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
            .orderBy('startTime')
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

  Future setNotifSchedules() async {
    NotificationService.init();
    try {
    await FirebaseFirestore.instance
            .collection('schedules')
            .where('uid', isEqualTo: user?.uid)
            .where('date', isEqualTo: DateFormat.yMd().format(DateTime.now()))
            .where('startTime', isGreaterThan: DateFormat.Hm().format(DateTime.now()))
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      for (var i = 0; i < querySnapshot.docs.length; i++) {
                        if(querySnapshot.docs[i]['remind']>0){
                          DateTime startTime = DateFormat.Hm().parse(querySnapshot.docs[i]['startTime']);
                          String newTime = DateFormat.Hm().format(startTime.subtract(querySnapshot.docs[i]['remind'] == 5 ? const Duration(minutes: 5) : querySnapshot.docs[i]['remind'] == 10 ? const Duration(minutes: 10) : querySnapshot.docs[i]['remind'] == 15 ? const Duration(minutes: 15) : const Duration(minutes: 0)));
                          DateTime date = DateFormat.yMd().add_Hm().parse(querySnapshot.docs[i]['date'] + " " + newTime);
                          
                          NotificationService.showScheduledNotification(
                            id:i+1*100,
                            title: 'Reminder FitOn',
                            body: 'Sebentar lagi jadwal '+querySnapshot.docs[i]['title']+' akan mulai!',
                            payload: 'Ayo Semangat!',
                            scheduledDate: date,
                          );
                        }
                        NotificationService.showScheduledNotification(
                          id:i+1*1000,
                          title: 'FitOn',
                          body: 'Jadwal kamu '+querySnapshot.docs[i]['title']+' sudah mulai!',
                          payload: 'Ayo Semangat!',
                          scheduledDate: DateFormat.yMd().add_Hm().parse(querySnapshot.docs[i]['date'] + " " + querySnapshot.docs[i]['startTime']),
                        );
                      }
                  }
              });
    } catch (e) {
      print(e);
    }
  }
}