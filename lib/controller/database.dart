import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class Database {
  // add task
  static Future<void> addTask(String title, String description) async {
    await firebaseFirestore.collection('tasks').add(
      {
        'title': title,
        'description': description,
      },
    );
  }

  // edit task
  static Future<void> updateTask(
      String id, String title, String description) async {
    await firebaseFirestore.collection('tasks').doc(id).update(
      {
        'title': title,
        'description': description,
      },
    ).whenComplete(
      () {
        print('Record Edited');
      },
    ).catchError((e) {
      print('Error Occured');
    });
  }

  // delete task
  static Future<void> deleteTask(String id) async {
    await firebaseFirestore.collection('tasks').doc(id).delete();
  }
}
