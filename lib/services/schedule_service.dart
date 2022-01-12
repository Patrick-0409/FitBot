import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/services/notification_service.dart';
import 'package:intl/intl.dart';

class SchedulesService {
  final user = FirebaseAuth.instance.currentUser;
  static Future<void> init() async {}

  Future getSchedules(String date) async {
    List itemsList = [];
    setNotifSchedules();
    try {
    await FirebaseFirestore.instance
            .collection('schedules')
            .where('uid', isEqualTo: user?.uid)
            .where('date', isEqualTo: date)
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      for (var i = 0; i < querySnapshot.docs.length; i++) {
                        // print(DateTime.parse(querySnapshot.docs[i]['date'] + " " + querySnapshot.docs[i]['startTime']));
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
    NotificationService.cancelAll();
    List itemsList = [];
    try {
    await FirebaseFirestore.instance
            .collection('schedules')
            .where('uid', isEqualTo: user?.uid)
            .where('startTime', isGreaterThan: DateFormat.jm().format(DateTime.now()))
            .get()
            .then((querySnapshot) {
                  if (querySnapshot.docs.length>0) {
                      for (var i = 0; i < querySnapshot.docs.length; i++) {
                        print(querySnapshot.docs[i]['remind']);
                        if(querySnapshot.docs[i]['remind']>0){
                          var time = DateFormat("HH:mm").format(DateFormat.jm().parse(querySnapshot.docs[i]['startTime']));
                          String count = time.toString().split(":")[0] + ":" + (int.parse(time.toString().split(":")[1])-querySnapshot.docs[i]['remind']).toString();
                          String tempTime = DateFormat.jm().format(DateFormat("HH:mm").parse(count));
                          DateTime date = DateFormat.yMd().add_jm().parse(querySnapshot.docs[i]['date'] + " " + tempTime);
                        
                          NotificationService.showScheduledNotification(
                            title: 'FitOn',
                            body: 'Sebentar lagi jadwal '+querySnapshot.docs[i]['title']+' akan mulai!',
                            payload: 'Fit.On',
                            scheduledDate: date,
                          );
                        }
                        NotificationService.showScheduledNotification(
                          title: 'FitOn',
                          body: 'Jadwal kamu '+querySnapshot.docs[i]['title']+' sudah mulai!',
                          payload: 'Fit.On',
                          scheduledDate: DateFormat.yMd().add_jm().parse(querySnapshot.docs[i]['date'] + " " + querySnapshot.docs[i]['startTime']),
                        );
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