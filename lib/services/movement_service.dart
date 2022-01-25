import 'package:cloud_firestore/cloud_firestore.dart';

class MovementService {

  Future getMovement(List<String> movement) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('movement')
          .where('__name__',whereIn: movement)
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
