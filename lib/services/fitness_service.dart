import 'package:cloud_firestore/cloud_firestore.dart';

class FitnessService {

  Future getFitness() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('fitness')
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.length > 0) {
          for (var i = 0; i < querySnapshot.docs.length; i++) {
            itemsList.add(querySnapshot.docs[i].data());
            // print(itemsList);
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
