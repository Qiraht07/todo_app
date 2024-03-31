import 'package:cloud_firestore/cloud_firestore.dart'; //This package provides functionality to interact with Cloud Firestore, a NoSQL database provided by Firebase.
import 'package:get_storage/get_storage.dart'; //A package for persistent storage, used here for storing user email.
import 'package:taskapp/models/task.dart'; //File containing the Task model.

///This section defines a class FirestoreRepository responsible for interacting with the Firestore database.
///create method: It creates a new task document in Firestore under the user's collection based on their email.
///The task document's ID is set to the task's ID, and its data is set to the task's map representation.

class FirestoreRepository {
  static Future<void> create({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      await FirebaseFirestore.instance
          .collection(email)
          .doc(task!.id)
          .set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///The get method retrieves all tasks associated with the user's email from Firestore.
  ///It returns a list of Task objects created from the retrieved data.

  static Future<List<Task>> get() async {
    List<Task> taskList = [];
    try {
      String email = GetStorage().read('email');
      final data = await FirebaseFirestore.instance.collection(email).get();
      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///The getTodayTasks method retrieves tasks for a specific date and where the isDone field is false.
  ///It returns a list of Task objects.

  static Future<List<Task>> getTodayTasks(String date) async {
    List<Task> taskList = [];
    try {
      String email = GetStorage().read('email');
      final data = await FirebaseFirestore.instance
          .collection(email)
          .where('date', isEqualTo: date)
          .where('isDone', isEqualTo: false)
          .get();

      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      print('$taskList, $date');
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///The update method updates a task document in Firestore based on the task's ID.

  static Future<void> update({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      data.doc(task!.id).update(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///The delete method deletes a task document from Firestore based on the task's ID.

  static Future<void> delete({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      data.doc(task!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///The deleteAllRemovedTasks method deletes multiple task documents from Firestore based on a list of Task objects.

  static Future<void> deleteAllRemovedTasks({List<Task>? taskList}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      for (var task in taskList!) {
        data.doc(task.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
